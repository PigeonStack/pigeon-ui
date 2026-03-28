"""FramelessHelper 单元测试：Windows 下窗口创建、属性、最大化/还原状态。"""

import sys

import pytest
from PySide6.QtCore import QObject
from PySide6.QtGui import QGuiApplication, QWindow
from PySide6.QtQml import QQmlApplicationEngine

import pigeon_ui
from pigeon_ui.frameless_helper import FramelessHelper

# 共享 QGuiApplication 实例
_app = QGuiApplication.instance() or QGuiApplication(sys.argv)

# 仅在 Windows 上运行 Win32 相关测试
win32_only = pytest.mark.skipif(sys.platform != "win32", reason="Windows only")


# ── 基本实例化 ──


def test_frameless_helper_creation():
    """FramelessHelper 可正常实例化。"""
    helper = FramelessHelper()
    assert helper is not None


def test_default_properties():
    """默认属性值应正确。"""
    helper = FramelessHelper()
    assert helper._title_bar_height == 36
    assert helper._resize_edge == 5
    assert helper._maximized is False
    assert helper._snapped is False
    assert helper._window is None


# ── 属性设置 ──


def test_title_bar_height_property():
    """titleBarHeight 属性可设置并触发信号。"""
    helper = FramelessHelper()
    signal_received = []
    helper.titleBarHeightChanged.connect(lambda: signal_received.append(True))

    helper._set_title_bar_height(48)
    assert helper._title_bar_height == 48
    assert len(signal_received) == 1


def test_title_bar_height_no_signal_if_same():
    """titleBarHeight 值不变时不应触发信号。"""
    helper = FramelessHelper()
    signal_received = []
    helper.titleBarHeightChanged.connect(lambda: signal_received.append(True))

    helper._set_title_bar_height(36)  # 默认值
    assert len(signal_received) == 0


def test_resize_edge_property():
    """resizeEdge 属性可设置并触发信号。"""
    helper = FramelessHelper()
    signal_received = []
    helper.resizeEdgeChanged.connect(lambda: signal_received.append(True))

    helper._set_resize_edge(8)
    assert helper._resize_edge == 8
    assert len(signal_received) == 1


def test_resize_edge_no_signal_if_same():
    """resizeEdge 值不变时不应触发信号。"""
    helper = FramelessHelper()
    signal_received = []
    helper.resizeEdgeChanged.connect(lambda: signal_received.append(True))

    helper._set_resize_edge(5)  # 默认值
    assert len(signal_received) == 0


# ── 排除区域 ──


def test_add_exclude_area():
    """addExcludeArea 可添加排除区域。"""
    helper = FramelessHelper()
    helper.addExcludeArea(10, 0, 40, 36)
    assert len(helper._exclude_areas) == 1
    assert helper._exclude_areas[0] == (10, 0, 40, 36)


def test_clear_exclude_areas():
    """clearExcludeAreas 可清空排除区域。"""
    helper = FramelessHelper()
    helper.addExcludeArea(10, 0, 40, 36)
    helper.addExcludeArea(60, 0, 40, 36)
    assert len(helper._exclude_areas) == 2

    helper.clearExcludeAreas()
    assert len(helper._exclude_areas) == 0


def test_set_maximize_button_rect():
    """setMaximizeButtonRect 可设置最大化按钮区域。"""
    helper = FramelessHelper()
    helper.setMaximizeButtonRect(100, 0, 46, 36)
    assert helper._maximize_btn_rect == (100, 0, 46, 36)


# ── 窗口绑定 ──


@win32_only
def test_window_binding():
    """设置 window 属性时应安装事件过滤器并设置 Win32 子类化。"""
    helper = FramelessHelper()
    window = QWindow()
    window.setFlag(window.flags())
    window.show()

    # 需要确保窗口有有效 HWND
    _app.processEvents()

    signal_received = []
    helper.windowChanged.connect(lambda: signal_received.append(True))

    helper._set_window(window)
    assert helper._window is window
    assert len(signal_received) == 1
    assert helper._hwnd != 0

    # 清理
    helper._set_window(None)
    window.close()


@win32_only
def test_window_unset_cleanup():
    """清除 window 时应清理 Win32 子类化。"""
    helper = FramelessHelper()
    window = QWindow()
    window.show()
    _app.processEvents()

    helper._set_window(window)
    old_hwnd = helper._hwnd
    assert old_hwnd != 0

    helper._set_window(None)
    assert helper._hwnd == 0
    assert helper._window is None

    window.close()


def test_window_set_none():
    """window 设置为 None 不应崩溃。"""
    helper = FramelessHelper()
    helper._set_window(None)
    assert helper._window is None


def test_window_set_same_no_signal():
    """window 设为相同值时不应触发信号。"""
    helper = FramelessHelper()
    signal_received = []
    helper.windowChanged.connect(lambda: signal_received.append(True))

    helper._set_window(None)  # 默认已是 None
    assert len(signal_received) == 0


# ── toggleMaximize / minimize ──


def test_toggle_maximize_without_window():
    """在无 window 时调用 toggleMaximize 不应崩溃。"""
    helper = FramelessHelper()
    helper.toggleMaximize()  # 不应抛异常


def test_minimize_without_window():
    """在无 window 时调用 minimize 不应崩溃。"""
    helper = FramelessHelper()
    helper.minimize()  # 不应抛异常


# ── Win32 hit test ──


@win32_only
def test_hit_test_without_window():
    """无窗口时 _hit_test 应返回 None。"""
    helper = FramelessHelper()
    result = helper._hit_test(100, 100)
    assert result is None


def test_non_win32_stubs():
    """非 Windows 平台 stub 方法不应崩溃。"""
    if sys.platform == "win32":
        pytest.skip("Only tests stubs on non-Windows")
    helper = FramelessHelper()
    helper._setup_win32(QWindow())
    helper._cleanup_win32()
    assert helper._check_snapped() is False
    assert helper._hit_test(0, 0) is None


# ── QML 注册 ──


def test_frameless_helper_qml_element():
    """FramelessHelper 应作为 QML 元素注册。"""
    engine = QQmlApplicationEngine()
    pigeon_ui.register(engine)

    # 验证 FramelessHelper 可实例化（作为 QmlElement 注册）
    helper = FramelessHelper()
    assert isinstance(helper, QObject)


# ── Win32 辅助函数 ──


@win32_only
def test_get_signed_short_positive():
    """_get_signed_short 对正值直接返回。"""
    from pigeon_ui.frameless_helper import _get_signed_short

    assert _get_signed_short(100) == 100
    assert _get_signed_short(0x7FFF) == 0x7FFF


@win32_only
def test_get_signed_short_negative():
    """_get_signed_short 对 >0x7FFF 的值转为负数。"""
    from pigeon_ui.frameless_helper import _get_signed_short

    assert _get_signed_short(0x8000) == -0x8000
    assert _get_signed_short(0xFFFF) == -1


@win32_only
def test_is_maximized_win32_no_hwnd():
    """无 hwnd 时 _is_maximized_win32 应返回 False。"""
    helper = FramelessHelper()
    assert helper._is_maximized_win32() is False


@win32_only
def test_event_filter_resize():
    """window 绑定后触发 resize 事件应更新状态。"""
    from PySide6.QtCore import QEvent

    helper = FramelessHelper()
    window = QWindow()
    window.show()
    _app.processEvents()

    helper._set_window(window)
    maximized_signals = []
    helper.maximizedChanged.connect(lambda: maximized_signals.append(True))

    # 手动调用 eventFilter 模拟 resize 事件
    resize_event = QEvent(QEvent.Type.Resize)
    result = helper.eventFilter(window, resize_event)
    assert result is False

    # 清理
    helper._set_window(None)
    window.close()
