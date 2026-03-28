import QtQuick
import QtQuick.Templates as T
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property var model: []              // ["Option A", "Option B"] or [{text, value}]
    property int currentIndex: -1
    property string placeholder: ""
    property color accentColor: PTheme.colorAccent
    property bool enabled: true

    // ── 只读 ──
    readonly property string currentText: {
        if (currentIndex < 0 || currentIndex >= model.length) return ""
        var item = model[currentIndex]
        if (typeof item === "string") return item
        if (item && item.text !== undefined) return item.text
        return ""
    }

    readonly property var currentValue: {
        if (currentIndex < 0 || currentIndex >= model.length) return undefined
        var item = model[currentIndex]
        if (typeof item === "object" && item && item.value !== undefined) return item.value
        return item
    }

    // ── 信号 ──
    signal selected(int index)

    // ── 内部状态 ──
    QtObject {
        id: _p
        property bool opened: false
        property bool hovered: false
        property real dropdownX: 0
        property real dropdownY: 0

        property color borderColor: {
            if (!root.enabled) return PTheme.colorBorder
            if (_p.opened)  return root.accentColor
            if (_p.hovered) return PTheme.colorTextSecondary
            return PTheme.colorBorder
        }

        function updateDropdownPos() {
            var gp = root.mapToItem(root._overlayParent, 0, root.height + PTheme.spacingXs)
            _p.dropdownX = gp.x
            _p.dropdownY = gp.y
        }

        onOpenedChanged: {
            if (opened) {
                updateDropdownPos()
                _overlay.visible = true
            }
        }
    }

    // ── 尺寸 ──
    implicitWidth: 220
    implicitHeight: PTheme.controlHeight

    Accessible.role: Accessible.ComboBox
    Accessible.name: root.currentText || root.placeholder || qsTr("Select")
    activeFocusOnTab: root.enabled

    // ── 挂载目标：组件树根节点 ──
    readonly property Item _overlayParent: {
        var p = root.parent
        while (p && p.parent) p = p.parent
        return p || root
    }

    // ── 触发按钮 ──
    Rectangle {
        id: _trigger
        anchors.fill: parent
        radius: PTheme.radiusSm
        color: root.enabled ? PTheme.colorSurfaceAlt : Qt.darker(PTheme.colorSurfaceAlt, 1.2)
        border.width: PTheme.borderWidth
        border.color: _p.borderColor

        Rectangle {
            anchors.fill: parent
            anchors.margins: -2
            radius: parent.radius + 2
            color: "transparent"
            border.width: root.activeFocus ? 2 : 0
            border.color: PTheme.colorFocusRing
        }

        Behavior on border.color {
            ColorAnimation { duration: PTheme.animFast }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: _arrow.left
            anchors.leftMargin: PTheme.spacingSm
            anchors.rightMargin: PTheme.spacingXs
            text: root.currentText || root.placeholder
            font.pixelSize: PTheme.fontSizeMd
            color: root.currentText
                ? (root.enabled ? PTheme.colorTextPrimary : PTheme.colorTextDisabled)
                : PTheme.colorTextDisabled
            elide: Text.ElideRight
        }

        PIcon {
            id: _arrow
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: PTheme.spacingSm
            name: "chevron_down"
            size: PTheme.iconSizeSm
            color: PTheme.colorTextSecondary
            rotation: _p.opened ? 180 : 0

            Behavior on rotation {
                NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
            onContainsMouseChanged: _p.hovered = containsMouse
            onClicked: {
                if (!root.enabled) return
                _p.opened = !_p.opened
            }
        }
    }

    // ── 下拉弹层（挂载到根节点） ──
    Item {
        id: _overlay
        parent: root._overlayParent
        anchors.fill: parent
        visible: false
        z: 998

        // 外部点击关闭
        MouseArea {
            anchors.fill: parent
            onClicked: _p.opened = false
        }

        Rectangle {
            id: _dropdown
            width: root.width
            height: Math.min(_listContent.contentHeight + PTheme.spacingXs * 2, PTheme.dropdownMaxHeight)
            radius: PTheme.radiusMd
            color: PTheme.colorSurface
            border.width: PTheme.borderWidth
            border.color: PTheme.colorBorder

            x: _p.dropdownX
            y: _p.dropdownY

            scale: _p.opened ? 1.0 : 0.95
            opacity: _p.opened ? 1.0 : 0.0
            transformOrigin: Item.Top

            Behavior on scale {
                NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
            }
            Behavior on opacity {
                NumberAnimation {
                    id: _fadeAnim
                    duration: PTheme.animFast
                }
            }

            // 防止点击穿透到遮罩
            MouseArea {
                anchors.fill: parent
            }

            ListView {
                id: _listContent
                anchors.fill: parent
                anchors.margins: PTheme.spacingXs
                model: root.model
                clip: true
                currentIndex: root.currentIndex

                delegate: T.Button {
                    id: _option
                    width: _listContent.width
                    height: PTheme.controlItemHeight

                    required property int index
                    required property var modelData

                    property bool isCurrent: root.currentIndex === index
                    property string optionText: {
                        if (typeof modelData === "string") return modelData
                        if (modelData && modelData.text !== undefined) return modelData.text
                        return ""
                    }

                    hoverEnabled: true
                    onClicked: {
                        root.currentIndex = index
                        root.selected(index)
                        _p.opened = false
                    }

                    contentItem: Text {
                        text: _option.optionText
                        font.pixelSize: PTheme.fontSizeMd
                        color: _option.isCurrent ? root.accentColor
                            : (_option.hovered ? PTheme.colorTextPrimary : PTheme.colorTextSecondary)
                        leftPadding: PTheme.spacingSm
                        verticalAlignment: Text.AlignVCenter

                        Behavior on color {
                            ColorAnimation { duration: PTheme.animFast }
                        }
                    }

                    background: Rectangle {
                        radius: PTheme.radiusSm
                        color: {
                            if (_option.isCurrent) return Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.1)
                            if (_option.down) return PTheme.colorStatePressed
                            if (_option.hovered) return PTheme.colorStateHover
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

        // 淡出结束后隐藏 overlay
        Connections {
            target: _fadeAnim
            function onRunningChanged() {
                if (!_fadeAnim.running && !_p.opened) {
                    _overlay.visible = false
                }
            }
        }
    }

    // ── 开关控制 ──
    onActiveFocusChanged: {
        if (!activeFocus && _p.opened) _p.opened = false
    }

    // ── 键盘交互 ──
    Keys.onSpacePressed: {
        if (root.enabled) _p.opened = !_p.opened
    }
    Keys.onReturnPressed: {
        if (root.enabled) _p.opened = !_p.opened
    }
    Keys.onEscapePressed: {
        if (_p.opened) _p.opened = false
    }
}
