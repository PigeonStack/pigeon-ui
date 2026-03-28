"""主题切换示例：dark/light 模式切换与主题 token 展示。"""

import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import pigeon_ui

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

pigeon_ui.register(engine)

engine.load(Path(__file__).parent / "ThemingExample.qml")

if not engine.rootObjects():
    sys.exit(1)

sys.exit(app.exec())
