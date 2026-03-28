import QtQuick
import QtQuick.Window
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property string title: ""
    property string message: ""
    property alias body: _bodyArea.data
    property string confirmText: qsTr("OK")
    property string cancelText: qsTr("Cancel")
    property bool showCancel: true
    property color accentColor: PTheme.colorAccent
    property int dialogWidth: 360
    property bool closeOnOverlay: false
    property bool closeOnEscape: true
    property bool modal: true

    // ── 信号 ──
    signal confirmed()
    signal cancelled()
    signal closed()

    // ── 内部状态 ──
    QtObject {
        id: _p
        property bool opened: false
        property Item previousFocusItem: null
    }

    visible: false
    anchors.fill: parent
    z: 999

    Accessible.role: Accessible.Dialog
    Accessible.name: root.title || qsTr("Dialog")

    // ── 公开方法 ──
    function open() {
        // 记住打开前的焦点，以便关闭后恢复
        _p.previousFocusItem = (Window.window && Window.window.activeFocusItem)
            ? Window.window.activeFocusItem : null

        // 自动挂载到 PWindow.contentArea，确保遮罩覆盖整个窗口内容区
        if (Window.window && Window.window.contentArea) {
            root.parent = Window.window.contentArea
        }
        root.visible = true
        _p.opened = true

        // 焦点设置到确认按钮
        _btnConfirm.forceActiveFocus()
    }
    function close() {
        _p.opened = false
    }

    // ── 焦点恢复 ──
    onVisibleChanged: {
        if (!visible && _p.previousFocusItem) {
            _p.previousFocusItem.forceActiveFocus()
            _p.previousFocusItem = null
        }
    }

    // ── 遮罩层 ──
    Rectangle {
        id: _overlay
        anchors.fill: parent
        radius: (Window.window && Window.window.contentArea)
            ? Window.window.contentArea.radius : 0
        color: PTheme.colorOverlay
        opacity: _p.opened ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: PTheme.animFast }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.closeOnOverlay)
                    root.close()
            }
        }
    }

    // ── 对话框卡片 ──
    Rectangle {
        id: _card
        anchors.centerIn: parent
        width: root.dialogWidth
        height: _content.implicitHeight + PTheme.spacingLg * 2
        color: PTheme.colorSurface
        radius: PTheme.radiusLg
        border.width: PTheme.borderWidth
        border.color: PTheme.colorBorder

        scale: _p.opened ? 1.0 : 0.9
        opacity: _p.opened ? 1.0 : 0

        Behavior on scale {
            NumberAnimation {
                duration: PTheme.animNormal
                easing.type: Easing.OutBack
            }
        }
        Behavior on opacity {
            NumberAnimation {
                id: _cardFadeAnim
                duration: PTheme.animFast
            }
        }

        // 退出动画结束后隐藏
        Connections {
            target: _cardFadeAnim
            function onRunningChanged() {
                if (!_cardFadeAnim.running && !_p.opened) {
                    root.visible = false
                    root.closed()
                }
            }
        }

        // 防止点击穿透到遮罩
        MouseArea {
            anchors.fill: parent
        }

        Column {
            id: _content
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: PTheme.spacingLg
            spacing: PTheme.spacingMd

            // 标题
            Text {
                visible: root.title !== ""
                text: root.title
                font.pixelSize: PTheme.fontSizeLg
                font.bold: true
                color: PTheme.colorTextPrimary
                width: parent.width
                wrapMode: Text.WordWrap
                Accessible.role: Accessible.Heading
            }

            // 消息
            Text {
                visible: root.message !== ""
                text: root.message
                font.pixelSize: PTheme.fontSizeMd
                color: PTheme.colorTextSecondary
                width: parent.width
                wrapMode: Text.WordWrap
            }

            // 自定义内容区域
            Item {
                id: _bodyArea
                width: parent.width
                implicitHeight: childrenRect.height
                visible: children.length > 0
            }

            // 按钮栏
            Row {
                anchors.right: parent.right
                spacing: PTheme.spacingSm
                layoutDirection: Qt.RightToLeft

                PButton {
                    id: _btnConfirm
                    text: root.confirmText
                    type: "primary"
                    accentColor: root.accentColor
                    activeFocusOnTab: true
                    Accessible.name: root.confirmText
                    onClicked: {
                        root.confirmed()
                        root.close()
                    }
                    Keys.onReturnPressed: clicked()
                }

                PButton {
                    id: _btnCancel
                    visible: root.showCancel
                    text: root.cancelText
                    type: "flat"
                    activeFocusOnTab: true
                    Accessible.name: root.cancelText
                    onClicked: {
                        root.cancelled()
                        root.close()
                    }
                    Keys.onReturnPressed: clicked()
                }
            }
        }
    }

    // ── 焦点陷阱：Tab 循环在按钮间 ──
    Keys.onTabPressed: function(event) {
        if (_btnCancel.visible) {
            if (_btnConfirm.activeFocus) _btnCancel.forceActiveFocus()
            else _btnConfirm.forceActiveFocus()
        }
        event.accepted = true
    }
    Keys.onBacktabPressed: function(event) {
        if (_btnCancel.visible) {
            if (_btnCancel.activeFocus) _btnConfirm.forceActiveFocus()
            else _btnCancel.forceActiveFocus()
        }
        event.accepted = true
    }

    // ── ESC 关闭 ──
    Keys.onEscapePressed: function(event) {
        if (root.closeOnEscape) {
            root.close()
            event.accepted = true
        }
    }
}
