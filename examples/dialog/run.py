"""弹窗组件示例：PDialog、PDrawer、PToast、PSnackbar。"""

import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import pigeon_ui

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

pigeon_ui.register(engine)

engine.load(Path(__file__).parent / "DialogExample.qml")

if not engine.rootObjects():
    sys.exit(1)

sys.exit(app.exec())
