"""PigeonUI 最小接入示例：外部项目接入样例。

用法：
    pip install pigeon-ui
    python examples/starter/main.py
"""

import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import pigeon_ui

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

pigeon_ui.register(engine)

engine.load(Path(__file__).parent / "main.qml")

if not engine.rootObjects():
    sys.exit(1)

sys.exit(app.exec())
