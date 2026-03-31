import QtQuick
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property string text: ""
    property string actionText: ""
    property int duration: 4000
    property color accentColor: PTheme.colorAccent
    property int maxWidth: 480

    // ── 信号 ──
    signal actionClicked()
    signal closed()

    // ── 内部状态 ──
    QtObject {
        id: _p
        property bool opened: false
    }

    anchors.left: parent ? parent.left : undefined
    anchors.right: parent ? parent.right : undefined
    anchors.bottom: parent ? parent.bottom : undefined
    height: _card.height + PTheme.spacingMd
    z: 999
    visible: false

    Accessible.role: Accessible.AlertMessage
    Accessible.name: root.text

    // ── 公开方法 ──
    function show(message, actionText) {
        if (message !== undefined) root.text = message
        if (actionText !== undefined) root.actionText = actionText
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
        anchors.bottom: parent.bottom
        anchors.bottomMargin: _p.opened ? PTheme.spacingSm : -height
        width: Math.min(root.maxWidth, _row.implicitWidth + PTheme.spacingMd * 2)
        height: _row.implicitHeight + PTheme.spacingSm * 2
        radius: PTheme.radiusMd
        color: PTheme.colorSurface
        border.width: PTheme.borderWidth
        border.color: PTheme.colorBorder

        Behavior on anchors.bottomMargin {
            NumberAnimation { duration: PTheme.animNormal; easing.type: Easing.OutCubic }
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

            Text {
                text: root.text
                font.pixelSize: PTheme.fontSizeMd
                color: PTheme.colorTextPrimary
                anchors.verticalCenter: parent.verticalCenter
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                width: Math.min(implicitWidth, root.maxWidth - PTheme.spacingMd * 2 - (root.actionText !== "" ? 80 : 0) - 16 - PTheme.spacingSm * 3)
            }

            // ── 操作按钮 ──
            Text {
                visible: root.actionText !== ""
                text: root.actionText
                font.pixelSize: PTheme.fontSizeMd
                font.bold: true
                color: _actionArea.containsMouse ? Qt.lighter(root.accentColor, 1.2) : root.accentColor
                anchors.verticalCenter: parent.verticalCenter

                Behavior on color {
                    ColorAnimation { duration: PTheme.animFast }
                }

                MouseArea {
                    id: _actionArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        root.actionClicked()
                        root.close()
                    }
                }
            }

            // ── 关闭按钮 ──
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
