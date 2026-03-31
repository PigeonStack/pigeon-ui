import QtQuick
import QtQuick.Window
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property int edge: Qt.LeftEdge       // Qt.LeftEdge | Qt.RightEdge
    property int drawerWidth: 280
    property bool closeOnOverlay: true
    property bool closeOnEscape: true
    property bool modal: true
    default property alias content: _contentArea.data

    // ── 信号 ──
    signal closed()

    // ── 内部状态 ──
    QtObject {
        id: _p
        property bool opened: false
        property Item previousFocusItem: null
    }

    visible: false
    anchors.fill: parent
    z: 998

    Accessible.role: Accessible.Pane
    Accessible.name: qsTr("Drawer")

    // ── 公开方法 ──
    function open() {
        _p.previousFocusItem = Window.window && Window.window.activeFocusItem
            ? Window.window.activeFocusItem : null

        if (Window.window && Window.window.contentArea) {
            root.parent = Window.window.contentArea
        }
        root.visible = true
        _p.opened = true
        root.forceActiveFocus()
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
            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.closeOnOverlay) root.close()
            }
        }
    }

    // ── 抽屉面板 ──
    Rectangle {
        id: _panel
        width: root.drawerWidth
        height: parent.height
        color: PTheme.colorSurface
        border.width: PTheme.borderWidth
        border.color: PTheme.colorBorder

        radius: {
            if (Window.window && Window.window.contentArea) {
                return Window.window.contentArea.radius
            }
            return 0
        }

        x: {
            if (root.edge === Qt.RightEdge) {
                return _p.opened ? parent.width - width : parent.width
            }
            return _p.opened ? 0 : -width
        }

        Behavior on x {
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
            target: _slideAnim
            function onRunningChanged() {
                if (!_slideAnim.running && !_p.opened) {
                    root.visible = false
                    root.closed()
                }
            }
        }

        // 防止点击穿透
        MouseArea {
            anchors.fill: parent
        }

        // ── 内容区 ──
        Item {
            id: _contentArea
            anchors.fill: parent
            anchors.margins: PTheme.spacingMd
        }
    }

    // ── ESC 关闭 ──
    Keys.onEscapePressed: function(event) {
        if (root.closeOnEscape) {
            root.close()
            event.accepted = true
        }
    }
}
