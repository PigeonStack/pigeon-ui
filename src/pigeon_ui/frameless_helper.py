"""为 PWindow 提供 Windows 原生窗口行为支持（Snap 布局、系统阴影等）。"""

import sys

from PySide6.QtCore import Property, QEvent, QObject, Signal, Slot
from PySide6.QtGui import QWindow
from PySide6.QtQml import QmlElement

if sys.platform == "win32":
    import ctypes
    import ctypes.wintypes

    user32 = ctypes.windll.user32
    dwmapi = ctypes.windll.dwmapi
    comctl32 = ctypes.windll.comctl32

    # 设置 DefSubclassProc 的参数和返回值类型
    comctl32.DefSubclassProc.argtypes = [
        ctypes.wintypes.HWND,  # hWnd
        ctypes.c_uint,  # uMsg
        ctypes.c_ulonglong,  # wParam (WPARAM = UINT_PTR)
        ctypes.c_longlong,  # lParam (LPARAM = LONG_PTR)
    ]
    comctl32.DefSubclassProc.restype = ctypes.c_longlong  # LRESULT

    comctl32.SetWindowSubclass.argtypes = [
        ctypes.wintypes.HWND,  # hWnd
        ctypes.c_void_p,  # pfnSubclass (SUBCLASSPROC)
        ctypes.c_ulonglong,  # uIdSubclass
        ctypes.c_ulonglong,  # dwRefData
    ]
    comctl32.SetWindowSubclass.restype = ctypes.wintypes.BOOL

    comctl32.RemoveWindowSubclass.argtypes = [
        ctypes.wintypes.HWND,
        ctypes.c_void_p,
        ctypes.c_ulonglong,
    ]
    comctl32.RemoveWindowSubclass.restype = ctypes.wintypes.BOOL

    # Windows 消息常量
    WM_NCHITTEST = 0x0084
    WM_NCCALCSIZE = 0x0083
    WM_GETMINMAXINFO = 0x0024

    # NCHITTEST 返回值
    HTCLIENT = 1
    HTCAPTION = 2
    HTLEFT = 10
    HTRIGHT = 11
    HTTOP = 12
    HTTOPLEFT = 13
    HTTOPRIGHT = 14
    HTBOTTOM = 15
    HTBOTTOMLEFT = 16
    HTBOTTOMRIGHT = 17
    HTMAXBUTTON = 9

    # 窗口样式
    GWL_STYLE = -16
    WS_THICKFRAME = 0x00040000
    WS_MAXIMIZEBOX = 0x00010000
    WS_MINIMIZEBOX = 0x00020000
    WS_CAPTION = 0x00C00000
    SWP_FRAMECHANGED = 0x0020
    SWP_NOMOVE = 0x0002
    SWP_NOSIZE = 0x0001
    SWP_NOZORDER = 0x0004

    # WM_SYSCOMMAND
    WM_SYSCOMMAND = 0x0112
    SC_MAXIMIZE = 0xF030
    SC_RESTORE = 0xF120

    # 系统度量
    SM_CXSCREEN = 0
    SM_CYSCREEN = 1

    # DWM 属性
    DWMWA_WINDOW_CORNER_PREFERENCE = 33
    DWMWCP_DONOTROUND = 1

    # MONITOR 常量
    MONITOR_DEFAULTTONEAREST = 2

    user32.GetWindowLongW.argtypes = [ctypes.wintypes.HWND, ctypes.c_int]
    user32.GetWindowLongW.restype = ctypes.c_long

    user32.ShowWindow.argtypes = [ctypes.wintypes.HWND, ctypes.c_int]
    user32.ShowWindow.restype = ctypes.wintypes.BOOL

    user32.SendMessageW.argtypes = [
        ctypes.wintypes.HWND,
        ctypes.c_uint,
        ctypes.c_ulonglong,
        ctypes.c_longlong,
    ]
    user32.SendMessageW.restype = ctypes.c_longlong

    SW_MAXIMIZE = 3
    SW_RESTORE = 9

    user32.SetWindowLongW.argtypes = [ctypes.wintypes.HWND, ctypes.c_int, ctypes.c_long]
    user32.SetWindowLongW.restype = ctypes.c_long

    user32.SetWindowPos.argtypes = [
        ctypes.wintypes.HWND,
        ctypes.wintypes.HWND,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_uint,
    ]
    user32.SetWindowPos.restype = ctypes.wintypes.BOOL

    user32.MonitorFromWindow.argtypes = [ctypes.wintypes.HWND, ctypes.wintypes.DWORD]
    user32.MonitorFromWindow.restype = ctypes.wintypes.HMONITOR

    user32.MonitorFromRect.argtypes = [ctypes.POINTER(ctypes.wintypes.RECT), ctypes.wintypes.DWORD]
    user32.MonitorFromRect.restype = ctypes.wintypes.HMONITOR

    user32.GetWindowRect.argtypes = [ctypes.wintypes.HWND, ctypes.POINTER(ctypes.wintypes.RECT)]
    user32.GetWindowRect.restype = ctypes.wintypes.BOOL

    class MONITORINFO(ctypes.Structure):
        _fields_ = [
            ("cbSize", ctypes.wintypes.DWORD),
            ("rcMonitor", ctypes.wintypes.RECT),
            ("rcWork", ctypes.wintypes.RECT),
            ("dwFlags", ctypes.wintypes.DWORD),
        ]

    user32.GetMonitorInfoW.argtypes = [ctypes.wintypes.HMONITOR, ctypes.POINTER(MONITORINFO)]
    user32.GetMonitorInfoW.restype = ctypes.wintypes.BOOL

    class MINMAXINFO(ctypes.Structure):
        _fields_ = [
            ("ptReserved", ctypes.wintypes.POINT),
            ("ptMaxSize", ctypes.wintypes.POINT),
            ("ptMaxPosition", ctypes.wintypes.POINT),
            ("ptMinTrackSize", ctypes.wintypes.POINT),
            ("ptMaxTrackSize", ctypes.wintypes.POINT),
        ]

    # SetWindowSubclass 回调类型
    SUBCLASSPROC = ctypes.WINFUNCTYPE(
        ctypes.c_longlong,  # LRESULT
        ctypes.wintypes.HWND,  # hWnd
        ctypes.c_uint,  # uMsg
        ctypes.c_ulonglong,  # wParam
        ctypes.c_longlong,  # lParam
        ctypes.c_ulonglong,  # uIdSubclass
        ctypes.c_ulonglong,  # dwRefData
    )

    # 持有回调引用防止 GC
    _subclass_procs: dict[int, SUBCLASSPROC] = {}  # type: ignore[valid-type]
    _subclass_helpers: dict[int, "FramelessHelper"] = {}
    _SUBCLASS_ID = 1

    def _get_signed_short(val: int) -> int:
        if val > 0x7FFF:
            val -= 0x10000
        return val

    class NCCALCSIZE_PARAMS(ctypes.Structure):
        _fields_ = [
            ("rgrc", ctypes.wintypes.RECT * 3),
            ("lppos", ctypes.c_void_p),
        ]

    WS_MAXIMIZE = 0x01000000

    def _subclass_wndproc(hwnd, msg, wparam, lparam, uid, ref_data):
        helper = _subclass_helpers.get(int(hwnd))
        if helper is None:
            return comctl32.DefSubclassProc(hwnd, msg, wparam, lparam)

        if msg == WM_NCHITTEST:
            gx = _get_signed_short(lparam & 0xFFFF)
            gy = _get_signed_short((lparam >> 16) & 0xFFFF)
            result = helper._hit_test(gx, gy)
            if result is not None:
                return result

        if msg == WM_NCCALCSIZE and wparam:
            # 通过窗口样式判断是否最大化（比 Qt visibility 更可靠）
            style = user32.GetWindowLongW(hwnd, GWL_STYLE)
            is_max = bool(style & WS_MAXIMIZE)
            if is_max:
                # 最大化时：将客户区裁剪到显示器工作区
                params = NCCALCSIZE_PARAMS.from_address(lparam)
                # 复制 rgrc[0] 到独立 RECT 再查找显示器
                proposed = ctypes.wintypes.RECT(
                    params.rgrc[0].left,
                    params.rgrc[0].top,
                    params.rgrc[0].right,
                    params.rgrc[0].bottom,
                )
                mon = user32.MonitorFromRect(ctypes.byref(proposed), MONITOR_DEFAULTTONEAREST)
                mi = MONITORINFO()
                mi.cbSize = ctypes.sizeof(MONITORINFO)
                user32.GetMonitorInfoW(mon, ctypes.byref(mi))
                params.rgrc[0].left = mi.rcWork.left
                params.rgrc[0].top = mi.rcWork.top
                params.rgrc[0].right = mi.rcWork.right
                params.rgrc[0].bottom = mi.rcWork.bottom
            # 非最大化时不修改 rgrc[0]：客户区 = 窗口区域（去掉所有非客户区）
            return 0

        if msg == WM_GETMINMAXINFO:
            # 先让系统填充默认值
            comctl32.DefSubclassProc(hwnd, msg, wparam, lparam)
            # 通过窗口当前矩形查找所在显示器
            rc = ctypes.wintypes.RECT()
            user32.GetWindowRect(hwnd, ctypes.byref(rc))
            mon = user32.MonitorFromRect(ctypes.byref(rc), MONITOR_DEFAULTTONEAREST)
            mi = MONITORINFO()
            mi.cbSize = ctypes.sizeof(MONITORINFO)
            user32.GetMonitorInfoW(mon, ctypes.byref(mi))
            work = mi.rcWork
            work_w = work.right - work.left
            work_h = work.bottom - work.top
            # 覆盖最大化尺寸、位置、和最大跟踪尺寸
            mmi = MINMAXINFO.from_address(lparam)
            mmi.ptMaxPosition.x = work.left - mi.rcMonitor.left
            mmi.ptMaxPosition.y = work.top - mi.rcMonitor.top
            mmi.ptMaxSize.x = work_w
            mmi.ptMaxSize.y = work_h
            mmi.ptMaxTrackSize.x = work_w
            mmi.ptMaxTrackSize.y = work_h
            return 0

        return comctl32.DefSubclassProc(hwnd, msg, wparam, lparam)

    # 预编译回调
    _global_subclass_proc = SUBCLASSPROC(_subclass_wndproc)


QML_IMPORT_NAME = "PigeonUI"
QML_IMPORT_MAJOR_VERSION = 1


@QmlElement
class FramelessHelper(QObject):
    """为无边框窗口提供原生 Snap 布局及边缘缩放支持。

    在 QML 中使用：
        FramelessHelper {
            window: root
            titleBarHeight: 36
            resizeEdge: 5
        }
    """

    windowChanged = Signal()
    titleBarHeightChanged = Signal()
    resizeEdgeChanged = Signal()
    maximizedChanged = Signal()
    snappedChanged = Signal()

    def __init__(self, parent: QObject | None = None) -> None:
        super().__init__(parent)
        self._window: QWindow | None = None
        self._title_bar_height: int = 36
        self._resize_edge: int = 5
        self._maximized: bool = False
        self._snapped: bool = False
        self._hwnd: int = 0
        self._exclude_areas: list[tuple[int, int, int, int]] = []
        self._maximize_btn_rect: tuple[int, int, int, int] | None = None

    # ── window property ──
    def _get_window(self) -> QObject | None:
        return self._window

    def _set_window(self, win: QObject | None) -> None:
        # QML Window 继承自 QQuickWindow -> QWindow
        actual_win: QWindow | None = None
        if isinstance(win, QWindow):
            actual_win = win
        elif win is not None:
            # QML 中 Window {} 的 QObject 通常可以转为 QWindow
            actual_win = win if isinstance(win, QWindow) else None

        if self._window is actual_win:
            return
        if self._window is not None:
            self._window.removeEventFilter(self)
            if sys.platform == "win32" and self._hwnd:
                self._cleanup_win32()
        self._window = actual_win
        if actual_win is not None:
            actual_win.installEventFilter(self)
            if sys.platform == "win32":
                self._setup_win32(actual_win)
        self.windowChanged.emit()

    window = Property(QObject, _get_window, _set_window, notify=windowChanged)

    # ── titleBarHeight property ──
    def _get_title_bar_height(self) -> int:
        return self._title_bar_height

    def _set_title_bar_height(self, h: int) -> None:
        if self._title_bar_height != h:
            self._title_bar_height = h
            self.titleBarHeightChanged.emit()

    titleBarHeight = Property(
        int, _get_title_bar_height, _set_title_bar_height, notify=titleBarHeightChanged
    )

    # ── resizeEdge property ──
    def _get_resize_edge(self) -> int:
        return self._resize_edge

    def _set_resize_edge(self, e: int) -> None:
        if self._resize_edge != e:
            self._resize_edge = e
            self.resizeEdgeChanged.emit()

    resizeEdge = Property(int, _get_resize_edge, _set_resize_edge, notify=resizeEdgeChanged)

    # ── maximized property (read-only from QML) ──
    def _get_maximized(self) -> bool:
        return self._maximized

    maximized = Property(bool, _get_maximized, notify=maximizedChanged)

    # ── snapped property (read-only from QML) ──
    def _get_snapped(self) -> bool:
        return self._snapped

    snapped = Property(bool, _get_snapped, notify=snappedChanged)

    # ── QML slots ──
    @Slot(int, int, int, int)
    def setMaximizeButtonRect(self, x: int, y: int, w: int, h: int) -> None:
        """告知 helper 最大化按钮的位置，用于 Windows 11 Snap 布局。"""
        self._maximize_btn_rect = (x, y, w, h)

    @Slot(int, int, int, int)
    def addExcludeArea(self, x: int, y: int, w: int, h: int) -> None:
        """添加标题栏中不可拖拽的区域（如按钮）。"""
        self._exclude_areas.append((x, y, w, h))

    @Slot()
    def clearExcludeAreas(self) -> None:
        self._exclude_areas.clear()

    @Slot()
    def toggleMaximize(self) -> None:
        if self._window is None:
            return
        if sys.platform == "win32" and self._hwnd:
            # 通过 WM_SYSCOMMAND 走系统原生路径（与双击标题栏一致）
            style = user32.GetWindowLongW(self._hwnd, GWL_STYLE)
            if style & WS_MAXIMIZE:
                user32.SendMessageW(self._hwnd, WM_SYSCOMMAND, SC_RESTORE, 0)
            else:
                user32.SendMessageW(self._hwnd, WM_SYSCOMMAND, SC_MAXIMIZE, 0)
        else:
            if self._window.visibility() == QWindow.Visibility.Maximized:
                self._window.showNormal()
            else:
                self._window.showMaximized()

    @Slot()
    def minimize(self) -> None:
        if self._window:
            self._window.showMinimized()

    # ── eventFilter: 跟踪窗口状态变化 ──
    def eventFilter(self, obj: QObject, event: QEvent) -> bool:
        if obj is self._window and event.type() in (
            QEvent.Type.Resize,
            QEvent.Type.WindowStateChange,
        ):
            new_max = self._window.visibility() == QWindow.Visibility.Maximized
            # 跨 DPI 屏幕时 Qt visibility 可能不准，用 Win32 状态做 fallback
            if not new_max and sys.platform == "win32" and self._hwnd:
                style = user32.GetWindowLongW(self._hwnd, GWL_STYLE)
                new_max = bool(style & WS_MAXIMIZE)
            if new_max != self._maximized:
                self._maximized = new_max
                self.maximizedChanged.emit()
            # 检测 Snap 贴边状态（仅非最大化时）
            new_snapped = False
            if not new_max:
                new_snapped = self._check_snapped()
            if new_snapped != self._snapped:
                self._snapped = new_snapped
                self.snappedChanged.emit()
        return False

    # ── Win32 平台相关 ──
    if sys.platform == "win32":

        def _setup_win32(self, win: QWindow) -> None:
            self._hwnd = int(win.winId())
            # 禁用 DWM 圆角（我们自己画圆角）
            pref = ctypes.c_int(DWMWCP_DONOTROUND)
            dwmapi.DwmSetWindowAttribute(
                self._hwnd, DWMWA_WINDOW_CORNER_PREFERENCE, ctypes.byref(pref), ctypes.sizeof(pref)
            )
            # 加回 WS_THICKFRAME 让系统支持边缘缩放和 Snap
            style = user32.GetWindowLongW(self._hwnd, GWL_STYLE)
            style |= WS_THICKFRAME | WS_MAXIMIZEBOX | WS_MINIMIZEBOX
            style &= ~WS_CAPTION  # 去掉标题栏
            user32.SetWindowLongW(self._hwnd, GWL_STYLE, style)
            # 通知系统窗口样式变化
            user32.SetWindowPos(
                self._hwnd,
                None,
                0,
                0,
                0,
                0,
                SWP_FRAMECHANGED | SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER,
            )
            # 使用 Win32 子类化拦截窗口消息
            _subclass_helpers[self._hwnd] = self
            comctl32.SetWindowSubclass(self._hwnd, _global_subclass_proc, _SUBCLASS_ID, 0)

        def _is_maximized_win32(self) -> bool:
            """通过 Win32 API 检查窗口是否最大化。"""
            if not self._hwnd:
                return False
            WS_MAXIMIZE = 0x01000000
            style = user32.GetWindowLongW(self._hwnd, GWL_STYLE)
            return bool(style & WS_MAXIMIZE)

        def _check_snapped(self) -> bool:
            """判断窗口是否处于贴边（Snap）状态。

            通过比较窗口矩形与所在显示器工作区，
            如果有 >= 2 条边贴合工作区边缘则认为处于 Snap 状态。
            """
            if not self._hwnd or not self._window:
                return False
            rc = ctypes.wintypes.RECT()
            user32.GetWindowRect(self._hwnd, ctypes.byref(rc))
            mon = user32.MonitorFromRect(ctypes.byref(rc), MONITOR_DEFAULTTONEAREST)
            mi = MONITORINFO()
            mi.cbSize = ctypes.sizeof(MONITORINFO)
            user32.GetMonitorInfoW(mon, ctypes.byref(mi))
            work = mi.rcWork
            tol = int(10 * self._window.devicePixelRatio())
            edges = 0
            if abs(rc.left - work.left) <= tol:
                edges += 1
            if abs(rc.right - work.right) <= tol:
                edges += 1
            if abs(rc.top - work.top) <= tol:
                edges += 1
            if abs(rc.bottom - work.bottom) <= tol:
                edges += 1
            return edges >= 2

        def _cleanup_win32(self) -> None:
            if self._hwnd:
                comctl32.RemoveWindowSubclass(self._hwnd, _global_subclass_proc, _SUBCLASS_ID)
                _subclass_helpers.pop(self._hwnd, None)
                self._hwnd = 0

        def _hit_test(self, global_x: int, global_y: int) -> int | None:
            """根据鼠标屏幕像素坐标返回 NCHITTEST 值。"""
            if self._window is None:
                return None

            win = self._window
            # 使用物理像素坐标获取窗口位置
            rect = ctypes.wintypes.RECT()
            user32.GetWindowRect(self._hwnd, ctypes.byref(rect))
            x = global_x - rect.left
            y = global_y - rect.top
            w = rect.right - rect.left
            h = rect.bottom - rect.top

            # DPI 缩放边缘大小
            dpr = win.devicePixelRatio()
            e = int(self._resize_edge * dpr)
            tbh = int(self._title_bar_height * dpr)

            is_max = win.visibility() == QWindow.Visibility.Maximized
            if not is_max:
                # 四角
                if x < e and y < e:
                    return HTTOPLEFT
                if x > w - e and y < e:
                    return HTTOPRIGHT
                if x < e and y > h - e:
                    return HTBOTTOMLEFT
                if x > w - e and y > h - e:
                    return HTBOTTOMRIGHT
                # 四边
                if x < e:
                    return HTLEFT
                if x > w - e:
                    return HTRIGHT
                if y < e:
                    return HTTOP
                if y > h - e:
                    return HTBOTTOM

            # 标题栏区域
            if y <= tbh:
                for ax, ay, aw, ah in self._exclude_areas:
                    ax2 = int(ax * dpr)
                    ay2 = int(ay * dpr)
                    aw2 = int(aw * dpr)
                    ah2 = int(ah * dpr)
                    if ax2 <= x <= ax2 + aw2 and ay2 <= y <= ay2 + ah2:
                        return HTCLIENT
                return HTCAPTION

            return HTCLIENT
    else:

        def _setup_win32(self, win: QWindow) -> None:
            pass

        def _cleanup_win32(self) -> None:
            pass

        def _check_snapped(self) -> bool:
            return False

        def _hit_test(self, global_x: int, global_y: int) -> int | None:
            return None
