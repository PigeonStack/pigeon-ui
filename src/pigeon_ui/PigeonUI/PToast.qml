import QtQuick
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property string text: ""
    property string type: "info"        // "info" | "success" | "warning" | "error"
    property int duration: 3000
    property int maxWidth: 360

    // ── 信号 ──
    signal closed()

    // ── 内部状态 ──
    QtObject {
        id: _p
        property bool opened: false

        property color bgColor: {
            switch (root.type) {
                case "success": return Qt.rgba(PTheme.colorSuccess.r, PTheme.colorSuccess.g, PTheme.colorSuccess.b, 0.15)
                case "warning": return Qt.rgba(PTheme.colorWarning.r, PTheme.colorWarning.g, PTheme.colorWarning.b, 0.15)
                case "error":   return Qt.rgba(PTheme.colorError.r, PTheme.colorError.g, PTheme.colorError.b, 0.15)
                default:        return Qt.rgba(PTheme.colorInfo.r, PTheme.colorInfo.g, PTheme.colorInfo.b, 0.15)
            }
        }

        property color accentColor: {
            switch (root.type) {
                case "success": return PTheme.colorSuccess
                case "warning": return PTheme.colorWarning
                case "error":   return PTheme.colorError
                default:        return PTheme.colorInfo
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

    anchors.left: parent ? parent.left : undefined
    anchors.right: parent ? parent.right : undefined
    height: _card.height + PTheme.spacingMd
    z: 999
    visible: false

    Accessible.role: Accessible.AlertMessage
    Accessible.name: root.text

    // ── 公开方法 ──
    function show(message, type) {
        if (message !== undefined) root.text = message
        if (type !== undefined) root.type = type
        root.visible = true
        _p.opened = true
        if (root.duration > 0) _timer.restart()
    }

    function close() {
        _p.opened = false
        _timer.stop()
    }

    // ── 自动关闭计时器 ──
    Timer {
        id: _timer
        interval: root.duration
        onTriggered: root.close()
    }

    // ── 通知卡片 ──
    Rectangle {
        id: _card
        anchors.horizontalCenter: parent.horizontalCenter
        y: _p.opened ? PTheme.spacingSm : -height
        width: Math.min(root.maxWidth, _row.implicitWidth + PTheme.spacingMd * 2)
        height: _row.implicitHeight + PTheme.spacingSm * 2
        radius: PTheme.radiusMd
        color: PTheme.colorSurface
        border.width: PTheme.borderWidth
        border.color: _p.accentColor

        Behavior on y {
            NumberAnimation {
                id: _slideAnim
                duration: PTheme.animNormal
                easing.type: Easing.OutCubic
            }
        }

        opacity: _p.opened ? 1.0 : 0.0
        Behavior on opacity {
            NumberAnimation {
                id: _fadeAnim
                duration: PTheme.animFast
                easing.type: Easing.OutCubic
            }
        }

        Connections {
            target: _fadeAnim
            function onRunningChanged() {
                if (!_fadeAnim.running && !_p.opened) {
                    root.visible = false
                    root.closed()
                }
            }
        }

        Row {
            id: _row
            anchors.centerIn: parent
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
                anchors.verticalCenter: parent.verticalCenter
                wrapMode: Text.WordWrap
                maximumLineCount: 3
                width: Math.min(implicitWidth, root.maxWidth - PTheme.spacingMd * 2 - PTheme.iconSizeMd - PTheme.iconSizeMd - PTheme.spacingSm * 3)
            }

            Item {
                width: PTheme.iconSizeMd
                height: PTheme.iconSizeMd
                anchors.verticalCenter: parent.verticalCenter

                PIcon {
                    anchors.centerIn: parent
                    name: "close"
                    size: PTheme.iconSizeXs
                    color: _closeArea.containsMouse ? PTheme.colorTextPrimary : PTheme.colorTextSecondary

                    Behavior on color {
                        ColorAnimation { duration: PTheme.animFast }
                    }
                }

                MouseArea {
                    id: _closeArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.close()
                }
            }
        }
    }
}
