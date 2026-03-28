"""临时诊断脚本 - 检查 WM_NCHITTEST 是否到达原生事件过滤器"""

import ctypes
import ctypes.wintypes
import sys

from PySide6.QtCore import QAbstractNativeEventFilter
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import pigeon_ui


class RawDebugFilter(QAbstractNativeEventFilter):
    def __init__(self):
        super().__init__()
        self.nchittest_count = 0
        self.msg_types = set()

    def nativeEventFilter(self, event_type, message):
        if event_type == b"windows_generic_MSG":
            msg_ptr = int(message)

            class MSG(ctypes.Structure):
                _fields_ = [
                    ("hwnd", ctypes.c_void_p),
                    ("message", ctypes.c_uint),
                    ("wParam", ctypes.c_ulonglong),
                    ("lParam", ctypes.c_longlong),
                    ("time", ctypes.c_ulong),
                    ("pt", ctypes.wintypes.POINT),
                ]

            msg = MSG.from_address(msg_ptr)
            self.msg_types.add(msg.message)
            if msg.message == 0x0084:  # WM_NCHITTEST
                self.nchittest_count += 1
                if self.nchittest_count <= 3:
                    print(f"WM_NCHITTEST received! hwnd={msg.hwnd}")
        return False, 0


app = QGuiApplication(sys.argv)
raw_filter = RawDebugFilter()
app.installNativeEventFilter(raw_filter)

engine = QQmlApplicationEngine()
pigeon_ui.register(engine)

from pathlib import Path  # noqa: E402

engine.load(Path("examples/Gallery.qml"))

if engine.rootObjects():
    from PySide6.QtCore import QTimer

    QTimer.singleShot(5000, app.quit)
    print("Move mouse over window for 5 sec...")
    app.exec()
    print(f"WM_NCHITTEST count: {raw_filter.nchittest_count}")
    print(f"Unique msg types seen: {len(raw_filter.msg_types)}")
    has_84 = 0x84 in raw_filter.msg_types
    has_200 = 0x200 in raw_filter.msg_types
    print(f"Has WM_NCHITTEST(0x84): {has_84}")
    print(f"Has WM_MOUSEMOVE(0x200): {has_200}")
else:
    print("FAIL: No root objects")
