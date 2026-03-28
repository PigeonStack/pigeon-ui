import QtQuick
import PigeonUI

Rectangle {
    id: root

    // ── 公开属性 ──
    property string text: ""
    property string type: "info"        // "info" | "success" | "warning" | "error"
    property bool closable: true

    // ── 信号 ──
    signal closed()

    Accessible.role: Accessible.AlertMessage
    Accessible.name: root.text

    // ── 内部状态 ──
    QtObject {
        id: _p

        property color accentColor: {
            switch (root.type) {
                case "success": return PTheme.colorSuccess
                case "warning": return PTheme.colorWarning
                case "error":   return PTheme.colorError
                default:        return PTheme.colorInfo
            }
        }

        property color bgColor: {
            switch (root.type) {
                case "success": return Qt.rgba(PTheme.colorSuccess.r, PTheme.colorSuccess.g, PTheme.colorSuccess.b, 0.1)
                case "warning": return Qt.rgba(PTheme.colorWarning.r, PTheme.colorWarning.g, PTheme.colorWarning.b, 0.1)
                case "error":   return Qt.rgba(PTheme.colorError.r, PTheme.colorError.g, PTheme.colorError.b, 0.1)
                default:        return Qt.rgba(PTheme.colorInfo.r, PTheme.colorInfo.g, PTheme.colorInfo.b, 0.1)
            }
        }

        property string iconName: {
            switch (root.type) {
                case "success": return "checkmark"
                case "warning": return "warning"
                case "error":   return "close"
                default:        return "info"
            }
        }
    }

    // ── 尺寸 ──
    implicitWidth: 400
    implicitHeight: _row.implicitHeight + PTheme.spacingSm * 2

    // ── 外观 ──
    color: _p.bgColor
    radius: PTheme.radiusMd
    border.width: PTheme.borderWidth
    border.color: Qt.rgba(_p.accentColor.r, _p.accentColor.g, _p.accentColor.b, 0.3)

    // ── 左侧色带 ──
    Rectangle {
        width: PTheme.borderWidthThick
        height: parent.height
        color: _p.accentColor
        anchors.left: parent.left
        radius: PTheme.radiusMd
    }

    Row {
        id: _row
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: PTheme.spacingMd
        anchors.rightMargin: PTheme.spacingSm
        spacing: PTheme.spacingSm

        PIcon {
            name: _p.iconName
            size: PTheme.iconSizeMd
            color: _p.accentColor
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: root.text
            font.pixelSize: PTheme.fontSizeMd
            color: PTheme.colorTextPrimary
            wrapMode: Text.WordWrap
            width: parent.width - PTheme.spacingMd - PTheme.iconSizeMd - PTheme.spacingSm * 2
                   - (root.closable ? PTheme.iconSizeMd + PTheme.spacingSm : 0)
            anchors.verticalCenter: parent.verticalCenter
        }

        Item {
            visible: root.closable
            width: PTheme.iconSizeMd
            height: PTheme.iconSizeMd
            anchors.verticalCenter: parent.verticalCenter

            PIcon {
                anchors.centerIn: parent
                name: "close"
                size: PTheme.iconSizeXs
                color: _bannerClose.containsMouse ? PTheme.colorTextPrimary : PTheme.colorTextSecondary

                Behavior on color {
                    ColorAnimation { duration: PTheme.animFast }
                }
            }

            MouseArea {
                id: _bannerClose
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.closed()
            }
        }
    }
}
