import QtQuick
import PigeonUI

Rectangle {
    id: root

    // ── 公开属性 ──
    property string text: ""
    property string type: "default"   // "default" | "primary" | "success" | "warning" | "error"
    property bool closable: false
    property color accentColor: PTheme.colorAccent

    // ── 信号 ──
    signal closed()

    Accessible.role: Accessible.StaticText
    Accessible.name: root.text

    // ── 内部状态 ──
    QtObject {
        id: _p

        property color bgColor: {
            switch (root.type) {
                case "primary": return Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.15)
                case "success": return Qt.rgba(PTheme.colorSuccess.r, PTheme.colorSuccess.g, PTheme.colorSuccess.b, 0.15)
                case "warning": return Qt.rgba(PTheme.colorWarning.r, PTheme.colorWarning.g, PTheme.colorWarning.b, 0.15)
                case "error":   return Qt.rgba(PTheme.colorError.r, PTheme.colorError.g, PTheme.colorError.b, 0.15)
                default:        return PTheme.colorSurfaceAlt
            }
        }

        property color textColor: {
            switch (root.type) {
                case "primary": return root.accentColor
                case "success": return PTheme.colorSuccess
                case "warning": return PTheme.colorWarning
                case "error":   return PTheme.colorError
                default:        return PTheme.colorTextSecondary
            }
        }

        property color borderColor: {
            switch (root.type) {
                case "primary": return Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.3)
                case "success": return Qt.rgba(PTheme.colorSuccess.r, PTheme.colorSuccess.g, PTheme.colorSuccess.b, 0.3)
                case "warning": return Qt.rgba(PTheme.colorWarning.r, PTheme.colorWarning.g, PTheme.colorWarning.b, 0.3)
                case "error":   return Qt.rgba(PTheme.colorError.r, PTheme.colorError.g, PTheme.colorError.b, 0.3)
                default:        return PTheme.colorBorder
            }
        }
    }

    // ── 尺寸 ──
    implicitWidth: _row.implicitWidth + PTheme.spacingSm * 2
    implicitHeight: PTheme.controlTagHeight

    // ── 外观 ──
    radius: PTheme.radiusSm
    color: _p.bgColor
    border.width: PTheme.borderWidth
    border.color: _p.borderColor

    Row {
        id: _row
        anchors.centerIn: parent
        spacing: PTheme.spacingXs

        Text {
            text: root.text
            font.pixelSize: PTheme.fontSizeSm
            color: _p.textColor
            anchors.verticalCenter: parent.verticalCenter
        }

        // ── 关闭按钮 ──
        Item {
            visible: root.closable
            width: PTheme.iconSizeSm
            height: PTheme.iconSizeSm
            anchors.verticalCenter: parent.verticalCenter

            PIcon {
                anchors.centerIn: parent
                name: "close"
                size: PTheme.iconSizeXs
                color: _closeArea.containsMouse ? _p.textColor : PTheme.colorTextSecondary

                Behavior on color {
                    ColorAnimation { duration: PTheme.animFast }
                }
            }

            MouseArea {
                id: _closeArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.closed()
            }
        }
    }
}
