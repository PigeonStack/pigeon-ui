from pathlib import Path

from PySide6.QtQml import QQmlApplicationEngine

# 导入以触发 @QmlElement 注册
from pigeon_ui.frameless_helper import FramelessHelper as _FramelessHelper  # noqa: F401


def register(engine: QQmlApplicationEngine) -> None:
    """将 PigeonUI QML 模块路径添加到 engine 的 import path。"""
    qml_dir = Path(__file__).parent
    engine.addImportPath(str(qml_dir))
