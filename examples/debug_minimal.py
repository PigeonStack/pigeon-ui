"""最小化测试 - 验证 DragHandler + startSystemMove 是否有效"""

import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import pigeon_ui

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
pigeon_ui.register(engine)

engine.loadData(b"""
import QtQuick

Window {
    id: root
    width: 400
    height: 300
    visible: true
    color: "#0d1117"
    flags: Qt.FramelessWindowHint | Qt.Window

    Rectangle {
        id: titleBar
        width: parent.width
        height: 40
        color: "#161b27"

        DragHandler {
            target: null
            onActiveChanged: {
                if (active) {
                    console.log("DragHandler active - calling startSystemMove")
                    root.startSystemMove()
                }
            }
        }

        Text {
            anchors.centerIn: parent
            text: "Drag me to move"
            color: "white"
        }
    }

    Rectangle {
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "transparent"

        Text {
            anchors.centerIn: parent
            text: "Minimal frameless test"
            color: "#8b9ab0"
        }
    }
}
""")

if engine.rootObjects():
    sys.exit(app.exec())
else:
    print("FAIL")
    sys.exit(1)
