import QtQuick
import QtQuick.Templates as T
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property var model: []              // [{text, icon}] or ["text"]
    property int menuWidth: 180

    // ── 信号 ──
    signal itemClicked(int index)

    // ── 内部状态 ──
    QtObject {
        id: _p
        property bool opened: false
        property real menuX: 0
        property real menuY: 0
        property int highlightIndex: -1
    }

    visible: false
    anchors.fill: parent
    z: 998

    Accessible.role: Accessible.PopupMenu
    Accessible.name: qsTr("Menu")

    // ── 公开方法 ──
    function open(x, y) {
        if (x !== undefined) _p.menuX = x
        if (y !== undefined) _p.menuY = y
        _p.highlightIndex = -1
        root.visible = true
        _p.opened = true
        root.forceActiveFocus()
    }

    function popup(x, y) { open(x, y) }

    function close() {
        _p.opened = false
    }

    // ── 外部点击关闭 ──
    MouseArea {
        anchors.fill: parent
        onClicked: root.close()
    }

    // ── 菜单面板 ──
    Rectangle {
        id: _menu
        x: _p.menuX
        y: _p.menuY
        width: root.menuWidth
        height: _list.contentHeight + PTheme.spacingXs * 2
        radius: PTheme.radiusMd
        color: PTheme.colorSurface
        border.width: PTheme.borderWidth
        border.color: PTheme.colorBorder

        scale: _p.opened ? 1.0 : 0.95
        opacity: _p.opened ? 1.0 : 0

        Behavior on scale {
            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
        }
        Behavior on opacity {
            NumberAnimation {
                id: _fadeAnim
                duration: PTheme.animFast
            }
        }

        Connections {
            target: _fadeAnim
            function onRunningChanged() {
                if (!_fadeAnim.running && !_p.opened) {
                    root.visible = false
                }
            }
        }

        // 防止点击穿透
        MouseArea {
            anchors.fill: parent
        }

        ListView {
            id: _list
            anchors.fill: parent
            anchors.margins: PTheme.spacingXs
            model: root.model
            interactive: false
            clip: true

            delegate: T.Button {
                id: _item
                width: _list.width
                height: PTheme.controlItemHeight

                Accessible.role: Accessible.MenuItem
                Accessible.name: _item.itemText

                required property int index
                required property var modelData

                property string itemText: {
                    if (typeof modelData === "string") return modelData
                    if (modelData && modelData.text !== undefined) return modelData.text
                    return ""
                }
                property string itemIcon: {
                    if (typeof modelData === "object" && modelData && modelData.icon !== undefined) return modelData.icon
                    return ""
                }

                property bool isHighlighted: _p.highlightIndex === index

                hoverEnabled: true
                onHoveredChanged: {
                    if (hovered) _p.highlightIndex = index
                }
                onClicked: {
                    root.itemClicked(index)
                    root.close()
                }

                contentItem: Row {
                    spacing: PTheme.spacingSm
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: PTheme.spacingSm

                    PIcon {
                        visible: _item.itemIcon !== ""
                        name: _item.itemIcon
                        size: PTheme.iconSizeMd
                        color: PTheme.colorTextSecondary
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        text: _item.itemText
                        font.pixelSize: PTheme.fontSizeMd
                        color: (_item.hovered || _item.isHighlighted)
                            ? PTheme.colorTextPrimary : PTheme.colorTextSecondary
                        anchors.verticalCenter: parent.verticalCenter

                        Behavior on color {
                            ColorAnimation { duration: PTheme.animFast }
                        }
                    }
                }

                background: Rectangle {
                    radius: PTheme.radiusSm
                    color: {
                        if (_item.down) return PTheme.colorStatePressed
                        if (_item.hovered || _item.isHighlighted) return PTheme.colorStateHover
                        return "transparent"
                    }

                    Behavior on color {
                        ColorAnimation { duration: PTheme.animFast }
                    }
                }

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }

    // ── 键盘导航 ──
    Keys.onEscapePressed: root.close()
    Keys.onUpPressed: {
        if (root.model.length === 0) return
        _p.highlightIndex = (_p.highlightIndex <= 0)
            ? root.model.length - 1 : _p.highlightIndex - 1
    }
    Keys.onDownPressed: {
        if (root.model.length === 0) return
        _p.highlightIndex = (_p.highlightIndex + 1) % root.model.length
    }
    Keys.onReturnPressed: {
        if (_p.highlightIndex >= 0 && _p.highlightIndex < root.model.length) {
            root.itemClicked(_p.highlightIndex)
            root.close()
        }
    }

    Component.onCompleted: if (visible) forceActiveFocus()
    onVisibleChanged: if (visible) forceActiveFocus()
}
