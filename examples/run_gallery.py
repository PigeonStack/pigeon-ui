"""PigeonUI Gallery 示例启动脚本"""

import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import pigeon_ui


def main() -> None:
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # 注册 PigeonUI QML 模块
    pigeon_ui.register(engine)

    qml_file = Path(__file__).parent / "Gallery.qml"
    engine.load(qml_file)

    if not engine.rootObjects():
        sys.exit(1)

    sys.exit(app.exec())


if __name__ == "__main__":
    main()
