import QtQuick
import QtQuick.Templates as T
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property alias model: repeater.model
    property int currentIndex: 0
    property color accentColor: PTheme.colorAccent
    property bool vertical: true              // true=竖向  false=横向
    property int itemHeight: PTheme.navItemHeight
    property int itemWidth: vertical ? width : 80
    property string textRole: "text"
    property string iconRole: "icon"
    property string iconSourceRole: "iconSource"
    property bool collapsed: false
    property int collapsedWidth: PTheme.navCollapsedWidth
    property int expandedWidth: PTheme.navExpandedWidth
    property bool showCollapseButton: false
    property alias bottomModel: _bottomRepeater.model
    property int bottomCurrentIndex: -1
    readonly property int count: repeater.count
    readonly property int bottomCount: _bottomRepeater.count

    Accessible.role: Accessible.List
    Accessible.name: qsTr("Navigation")

    // ── 信号 ──
    signal itemClicked(int index)
    signal bottomItemClicked(int index)

    // ── 便捷方法 ──
    function toggle() { collapsed = !collapsed }

    // ── 尺寸 ──
    implicitWidth: vertical
        ? (collapsed ? collapsedWidth : expandedWidth)
        : (itemWidth * repeater.count + PTheme.spacingXs * (repeater.count - 1))
    implicitHeight: vertical
        ? (itemHeight * repeater.count + PTheme.spacingXs * (repeater.count - 1))
        : itemHeight

    // ── 内部状态 ──
    QtObject {
        id: _p
        property int hoveredIndex: -1

        // 指示条目标位置
        property real targetX: root.vertical ? 0 : _itemX(root.currentIndex)
        property real targetY: root.vertical ? _itemY(root.currentIndex) : 0
        property real targetW: root.vertical ? 3 : root.itemWidth
        property real targetH: root.vertical ? root.itemHeight : 3

        // 悬浮背景目标位置
        property real hoverX: root.vertical
            ? PTheme.spacingXs
            : _itemX(hoveredIndex)
        property real hoverY: root.vertical
            ? _itemY(hoveredIndex)
            : 0
        property real hoverW: root.vertical
            ? root.width - PTheme.spacingXs * 2
            : root.itemWidth
        property real hoverH: root.itemHeight

        function _itemX(index) {
            if (index < 0 || !root.vertical) {
                return index * (root.itemWidth + PTheme.spacingXs)
            }
            return 0
        }

        function _itemY(index) {
            if (index < 0 || root.vertical) {
                return index * (root.itemHeight + PTheme.spacingXs)
            }
            return 0
        }

        // 底部项状态
        property int bottomHoveredIndex: -1
        property real bottomTargetY: _bottomItemY(root.bottomCurrentIndex)
        property real bottomHoverY: _bottomItemY(bottomHoveredIndex)

        function _bottomItemY(index) {
            if (index < 0) return 0
            return index * (root.itemHeight + PTheme.spacingXs)
        }
    }

    // ── 列表项 ──
    Flickable {
        id: _flickable
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: _bottomDivider.visible ? _bottomDivider.top
            : (_collapseBtn.visible ? _collapseDivider.top : parent.bottom)
        anchors.bottomMargin: _bottomDivider.visible ? PTheme.spacingXs : 0
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: root.vertical
            ? Flickable.VerticalFlick : Flickable.HorizontalFlick

        contentWidth: root.vertical ? width : _contentSize
        contentHeight: root.vertical ? _contentSize : height
        interactive: root.vertical
            ? contentHeight > height
            : contentWidth > width

        property real _contentSize: repeater.count > 0
            ? repeater.count * (root.vertical ? root.itemHeight : root.itemWidth)
              + (repeater.count - 1) * PTheme.spacingXs
            : 0

        // ── 动态跟随指示条 ──
        Rectangle {
            id: indicator
            visible: root.currentIndex >= 0
            color: root.accentColor
            radius: PTheme.radiusSm

            width: root.vertical ? 3 : _p.targetW
            height: root.vertical ? _p.targetH : 3

            x: root.vertical ? 0 : _p.targetX
            y: root.vertical ? _p.targetY : (root.itemHeight - 3)

            Behavior on x {
                NumberAnimation { duration: PTheme.animNormal; easing.type: Easing.OutCubic }
            }
            Behavior on y {
                NumberAnimation { duration: PTheme.animNormal; easing.type: Easing.OutCubic }
            }
            Behavior on width {
                NumberAnimation { duration: PTheme.animNormal; easing.type: Easing.OutCubic }
            }
            Behavior on height {
                NumberAnimation { duration: PTheme.animNormal; easing.type: Easing.OutCubic }
            }
        }

        // ── 悬浮高亮背景 ──
        Rectangle {
            id: hoverBg
            color: PTheme.colorStateHover
            radius: PTheme.radiusSm
            visible: _p.hoveredIndex >= 0
            x: _p.hoverX
            y: _p.hoverY
            width: _p.hoverW
            height: _p.hoverH
            opacity: _p.hoveredIndex >= 0 ? 1.0 : 0.0
        }

        Repeater {
            id: repeater

            delegate: T.Button {
                id: navItem
                x: root.vertical ? 0 : index * (root.itemWidth + PTheme.spacingXs)
                y: root.vertical ? index * (root.itemHeight + PTheme.spacingXs) : 0
                width: root.vertical ? root.width : root.itemWidth
                height: root.itemHeight

                required property int index
                required property var modelData

                Accessible.role: Accessible.ListItem
                Accessible.name: navItem.itemText

                property bool isCurrent: root.currentIndex === index
                property string itemText: {
                    if (typeof modelData === "string") return modelData
                    if (modelData && modelData[root.textRole] !== undefined)
                        return modelData[root.textRole]
                    return ""
                }
                property string itemIcon: {
                    if (typeof modelData === "string") return ""
                    if (modelData && modelData[root.iconRole] !== undefined)
                        return modelData[root.iconRole]
                    return ""
                }
                property string itemIconSource: {
                    if (typeof modelData === "string") return ""
                    if (modelData && modelData[root.iconSourceRole] !== undefined)
                        return modelData[root.iconSourceRole]
                    return ""
                }

                hoverEnabled: true
                onHoveredChanged: {
                    if (hovered) _p.hoveredIndex = index
                    else if (_p.hoveredIndex === index) _p.hoveredIndex = -1
                }
                onClicked: {
                    root.currentIndex = index
                    root.bottomCurrentIndex = -1
                    root.itemClicked(index)
                }

                contentItem: Item {
                    PIcon {
                        id: _navIcon
                        name: navItem.itemIcon
                        source: navItem.itemIconSource
                        visible: navItem.itemIcon !== "" || navItem.itemIconSource !== ""
                        size: PTheme.iconSizeLg
                        anchors.verticalCenter: parent.verticalCenter
                        color: navItem.isCurrent
                            ? root.accentColor
                            : navItem.hovered
                                ? PTheme.colorTextPrimary
                                : PTheme.colorTextSecondary
                        x: {
                            if (navItem.itemIcon === "" && navItem.itemIconSource === "") return 0
                            if (root.collapsed)
                                return (parent.width - PTheme.iconSizeLg) / 2
                            if (root.vertical)
                                return PTheme.spacingMd
                            // 横向：图标+文字整体居中
                            if (navItem.itemText)
                                return (parent.width - PTheme.iconSizeLg - PTheme.spacingSm
                                    - _navText.implicitWidth) / 2
                            return (parent.width - PTheme.iconSizeLg) / 2
                        }

                        Behavior on x {
                            NumberAnimation {
                                duration: PTheme.animNormal
                                easing.type: Easing.OutCubic
                            }
                        }
                        Behavior on color {
                            ColorAnimation { duration: PTheme.animFast }
                        }
                    }

                    Text {
                        id: _navText
                        text: navItem.itemText
                        font.pixelSize: PTheme.fontSizeMd
                        font.bold: navItem.isCurrent
                        anchors.verticalCenter: parent.verticalCenter
                        color: navItem.isCurrent
                            ? root.accentColor
                            : navItem.hovered
                                ? PTheme.colorTextPrimary
                                : PTheme.colorTextSecondary
                        opacity: root.collapsed ? 0 : 1
                        x: {
                            if (navItem.itemIcon !== "" || navItem.itemIconSource !== "")
                                return _navIcon.x + PTheme.iconSizeLg + PTheme.spacingSm
                            if (root.vertical)
                                return PTheme.spacingMd
                            return (parent.width - implicitWidth) / 2
                        }

                        Behavior on x {
                            NumberAnimation {
                                duration: PTheme.animNormal
                                easing.type: Easing.OutCubic
                            }
                        }
                        Behavior on opacity {
                            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
                        }
                        Behavior on color {
                            ColorAnimation { duration: PTheme.animFast }
                        }
                    }
                }

                background: Item {}

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }

    // ── 底部导航分割线 ──
    Rectangle {
        id: _bottomDivider
        visible: _bottomRepeater.count > 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: _bottomContainer.top
        anchors.bottomMargin: PTheme.spacingXs
        height: PTheme.borderWidth
        color: PTheme.colorDivider
    }

    // ── 底部固定项 ──
    Item {
        id: _bottomContainer
        visible: _bottomRepeater.count > 0
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: _collapseBtn.visible ? _collapseDivider.top : parent.bottom
        anchors.bottomMargin: _collapseBtn.visible ? PTheme.spacingXs : 0
        height: _bottomRepeater.count > 0
            ? _bottomRepeater.count * root.itemHeight
              + (_bottomRepeater.count - 1) * PTheme.spacingXs
            : 0

        // 底部指示条
        Rectangle {
            id: _bottomIndicator
            visible: root.bottomCurrentIndex >= 0
            color: root.accentColor
            radius: PTheme.radiusSm
            width: 3
            height: root.itemHeight
            x: 0
            y: _p.bottomTargetY

            Behavior on y {
                NumberAnimation { duration: PTheme.animNormal; easing.type: Easing.OutCubic }
            }
        }

        // 底部悬浮高亮
        Rectangle {
            id: _bottomHoverBg
            visible: _p.bottomHoveredIndex >= 0
            color: PTheme.colorStateHover
            radius: PTheme.radiusSm
            x: PTheme.spacingXs
            y: _p.bottomHoverY
            width: root.width - PTheme.spacingXs * 2
            height: root.itemHeight
            opacity: _p.bottomHoveredIndex >= 0 ? 1.0 : 0.0
        }

        Repeater {
            id: _bottomRepeater

            delegate: T.Button {
                id: bottomNavItem
                x: 0
                y: index * (root.itemHeight + PTheme.spacingXs)
                width: root.width
                height: root.itemHeight

                required property int index
                required property var modelData

                property bool isCurrent: root.bottomCurrentIndex === index
                property string itemText: {
                    if (typeof modelData === "string") return modelData
                    if (modelData && modelData[root.textRole] !== undefined)
                        return modelData[root.textRole]
                    return ""
                }
                property string itemIcon: {
                    if (typeof modelData === "string") return ""
                    if (modelData && modelData[root.iconRole] !== undefined)
                        return modelData[root.iconRole]
                    return ""
                }
                property string itemIconSource: {
                    if (typeof modelData === "string") return ""
                    if (modelData && modelData[root.iconSourceRole] !== undefined)
                        return modelData[root.iconSourceRole]
                    return ""
                }

                hoverEnabled: true
                onHoveredChanged: {
                    if (hovered) _p.bottomHoveredIndex = index
                    else if (_p.bottomHoveredIndex === index) _p.bottomHoveredIndex = -1
                }
                onClicked: {
                    root.bottomCurrentIndex = index
                    root.currentIndex = -1
                    root.bottomItemClicked(index)
                }

                contentItem: Item {
                    PIcon {
                        id: _bottomNavIcon
                        name: bottomNavItem.itemIcon
                        source: bottomNavItem.itemIconSource
                        visible: bottomNavItem.itemIcon !== "" || bottomNavItem.itemIconSource !== ""
                        size: PTheme.iconSizeLg
                        anchors.verticalCenter: parent.verticalCenter
                        color: bottomNavItem.isCurrent
                            ? root.accentColor
                            : bottomNavItem.hovered
                                ? PTheme.colorTextPrimary
                                : PTheme.colorTextSecondary
                        x: {
                            if (bottomNavItem.itemIcon === "" && bottomNavItem.itemIconSource === "") return 0
                            if (root.collapsed)
                                return (parent.width - PTheme.iconSizeLg) / 2
                            return PTheme.spacingMd
                        }

                        Behavior on x {
                            NumberAnimation {
                                duration: PTheme.animNormal
                                easing.type: Easing.OutCubic
                            }
                        }
                        Behavior on color {
                            ColorAnimation { duration: PTheme.animFast }
                        }
                    }

                    Text {
                        id: _bottomNavText
                        text: bottomNavItem.itemText
                        font.pixelSize: PTheme.fontSizeMd
                        font.bold: bottomNavItem.isCurrent
                        anchors.verticalCenter: parent.verticalCenter
                        color: bottomNavItem.isCurrent
                            ? root.accentColor
                            : bottomNavItem.hovered
                                ? PTheme.colorTextPrimary
                                : PTheme.colorTextSecondary
                        opacity: root.collapsed ? 0 : 1
                        x: {
                            if (bottomNavItem.itemIcon !== "" || bottomNavItem.itemIconSource !== "")
                                return _bottomNavIcon.x + PTheme.iconSizeLg + PTheme.spacingSm
                            return PTheme.spacingMd
                        }

                        Behavior on x {
                            NumberAnimation {
                                duration: PTheme.animNormal
                                easing.type: Easing.OutCubic
                            }
                        }
                        Behavior on opacity {
                            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
                        }
                        Behavior on color {
                            ColorAnimation { duration: PTheme.animFast }
                        }
                    }
                }

                background: Item {}

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }

    // ── 底部折叠分割线 ──
    Rectangle {
        id: _collapseDivider
        visible: _collapseBtn.visible
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: _collapseBtn.top
        anchors.bottomMargin: PTheme.spacingXs
        height: PTheme.borderWidth
        color: PTheme.colorDivider
    }

    // ── 底部折叠按钮 ──
    T.Button {
        id: _collapseBtn
        visible: root.vertical && root.showCollapseButton
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: root.itemHeight
        onClicked: root.toggle()

        contentItem: Item {
            PIcon {
                anchors.centerIn: parent
                name: root.collapsed ? "chevron_right" : "chevron_left"
                size: PTheme.iconSizeMd
                color: _collapseBtn.hovered
                    ? PTheme.colorTextPrimary
                    : PTheme.colorTextSecondary

                Behavior on color {
                    ColorAnimation { duration: PTheme.animFast }
                }
            }
        }

        background: Rectangle {
            color: _collapseBtn.hovered
                ? PTheme.colorStateHover : "transparent"
            radius: PTheme.radiusSm

            Behavior on color {
                ColorAnimation { duration: PTheme.animFast }
            }
        }

        HoverHandler {
            cursorShape: Qt.PointingHandCursor
        }
    }
}
