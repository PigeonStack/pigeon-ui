import QtQuick
import QtQuick.Effects
import QtQuick.Templates as T
import PigeonUI

Window {
    id: root

    // ── 公开属性 ──
    property alias pages: _pagesContainer.data
    readonly property Item contentArea: windowContent
    property int windowRadius: PTheme.radiusLg
    property color windowBg: PTheme.colorBg
    property color titleBarColor: PTheme.colorSurface
    property string windowTitle: "PigeonUI Application"
    property int windowTitleSize: PTheme.fontSizeSm
    property bool showTitleBar: true
    property bool resizable: true
    property bool showSidebar: false
    property color sidebarColor: PTheme.colorSurface
    property alias navBar: _sidebarNav

    // ── 窗口配置 ──
    width: 800
    height: 600
    visible: true
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window

    // ── 私有状态 ──
    QtObject {
        id: _p
        property bool maximized: false
        property bool snapped: false
        property bool docked: maximized || snapped
        property int shadowSize: _p.docked ? 0 : PTheme.windowShadowRadius
        property int currentRadius: _p.docked ? 0 : root.windowRadius
    }

    // ── 无边框辅助 ──
    FramelessHelper {
        id: framelessHelper
        titleBarHeight: root.showTitleBar
            ? titleBar.height + _p.shadowSize
            : 0
        resizeEdge: root.resizable
            ? PTheme.windowResizeEdge + _p.shadowSize
            : 0
        onMaximizedChanged: _p.maximized = framelessHelper.maximized
        onSnappedChanged: _p.snapped = framelessHelper.snapped
        Component.onCompleted: {
            framelessHelper.window = root
            _p.maximized = framelessHelper.maximized
            _p.snapped = framelessHelper.snapped
        }
    }

    // ── 阴影层 ──
    Rectangle {
        id: shadowSource
        anchors.fill: windowContent
        radius: _p.currentRadius
        color: root.windowBg
        visible: false
    }

    MultiEffect {
        source: shadowSource
        anchors.fill: shadowSource
        shadowEnabled: !_p.docked
        shadowColor: PTheme.windowShadowColor
        shadowBlur: 1.0
        shadowHorizontalOffset: 0
        shadowVerticalOffset: 2
    }

    // ── 窗口主体 ──
    Rectangle {
        id: windowContent
        anchors.fill: parent
        anchors.margins: _p.shadowSize
        radius: _p.currentRadius
        color: root.windowBg
        clip: true

        // ── 边框 ──
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.width: _p.docked ? 0 : 1
            border.color: PTheme.colorBorder
            z: 100
        }

        // ── 标题栏 ──
        Rectangle {
            id: titleBar
            width: parent.width
            height: root.showTitleBar ? PTheme.windowTitleBarHeight : 0
            visible: root.showTitleBar
            color: root.titleBarColor

            // 顶部圆角遮罩 —— 仅在有圆角时裁剪
            radius: _p.currentRadius
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: parent.radius
                color: parent.color
            }

            // 拖拽移动（非 Windows 平台 fallback，Windows 通过 HTCAPTION 处理）
            DragHandler {
                target: null
                onActiveChanged: if (active) root.startSystemMove()
            }

            // 标题文字
            Text {
                text: root.windowTitle
                font.pixelSize: root.windowTitleSize
                color: PTheme.colorTextSecondary
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: PTheme.spacingMd
            }

            // ── 窗口控制按钮 ──
            Row {
                id: windowControls
                anchors.right: parent.right
                anchors.rightMargin: PTheme.spacingXs
                anchors.verticalCenter: parent.verticalCenter
                spacing: 0

                // 更新排除区域和最大化按钮位置
                onXChanged: _updateHelperAreas()
                onWidthChanged: _updateHelperAreas()
                Component.onCompleted: _updateHelperAreas()

                function _updateHelperAreas() {
                    framelessHelper.clearExcludeAreas()
                    // 坐标需加阴影偏移（按钮在 windowContent 内，有 shadowSize 边距）
                    var gx = windowControls.x + _p.shadowSize
                    var gy = _p.shadowSize
                    framelessHelper.addExcludeArea(
                        gx, gy,
                        windowControls.width + PTheme.spacingXs,
                        titleBar.height
                    )
                    // 最大化按钮位置（相对窗口）
                    var maxBtnGlobalX = gx + btnMin.width
                    framelessHelper.setMaximizeButtonRect(
                        maxBtnGlobalX,
                        gy,
                        btnMax.width,
                        btnMax.height
                    )
                }

                // 最小化
                T.Button {
                    id: btnMin
                    width: PTheme.windowTitleBarHeight + 8
                    height: PTheme.windowTitleBarHeight
                    onClicked: framelessHelper.minimize()

                    contentItem: PIcon {
                        name: "subtract"
                        size: PTheme.iconSizeMd
                        color: PTheme.colorTextSecondary
                    }

                    background: Rectangle {
                        color: btnMin.hovered
                            ? PTheme.colorStatePressed : "transparent"
                        Behavior on color {
                            ColorAnimation { duration: PTheme.animFast }
                        }
                    }
                }

                // 最大化/还原
                T.Button {
                    id: btnMax
                    width: PTheme.windowTitleBarHeight + 8
                    height: PTheme.windowTitleBarHeight
                    onClicked: framelessHelper.toggleMaximize()

                    contentItem: PIcon {
                        name: _p.maximized ? "square_multiple" : "maximize"
                        size: PTheme.iconSizeMd
                        color: PTheme.colorTextSecondary
                    }

                    background: Rectangle {
                        color: btnMax.hovered
                            ? PTheme.colorStatePressed : "transparent"
                        Behavior on color {
                            ColorAnimation { duration: PTheme.animFast }
                        }
                    }
                }

                // 关闭
                T.Button {
                    id: btnClose
                    width: PTheme.windowTitleBarHeight + 8
                    height: PTheme.windowTitleBarHeight
                    onClicked: root.close()

                    contentItem: PIcon {
                        name: "close"
                        size: PTheme.iconSizeMd
                        color: btnClose.hovered
                            ? PTheme.colorTextPrimary
                            : PTheme.colorTextSecondary
                    }

                    background: Rectangle {
                        anchors.fill: parent
                        color: btnClose.hovered
                            ? PTheme.colorError : "transparent"
                        topRightRadius: _p.currentRadius

                        Behavior on color {
                            ColorAnimation { duration: PTheme.animFast }
                        }
                    }
                }
            }
        }

        // ── 侧边栏 ──
        Rectangle {
            id: _sidebar
            anchors.top: titleBar.bottom
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            width: root.showSidebar
                ? _sidebarNav.implicitWidth + PTheme.spacingXs * 2
                : 0
            color: root.sidebarColor
            clip: true
            bottomLeftRadius: _p.currentRadius

            Behavior on width {
                NumberAnimation {
                    duration: PTheme.animNormal
                    easing.type: Easing.OutCubic
                }
            }

            // 右侧分割线
            Rectangle {
                anchors.right: parent.right
                width: PTheme.borderWidth
                height: parent.height
                color: PTheme.colorDivider
                visible: root.showSidebar
            }

            PNavBar {
                id: _sidebarNav
                anchors.fill: parent
                anchors.topMargin: PTheme.spacingSm
                anchors.leftMargin: PTheme.spacingXs
                anchors.rightMargin: PTheme.spacingXs
                anchors.bottomMargin: PTheme.spacingXs
                showCollapseButton: true
            }
        }

        // ── 内容区域 ──
        Rectangle {
            id: _pagesContainer
            anchors.top: titleBar.bottom
            anchors.left: _sidebar.right
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: "transparent"
            bottomLeftRadius: _p.currentRadius
            clip: true

            property int _currentIdx: {
                if (_sidebarNav.currentIndex >= 0)
                    return _sidebarNav.currentIndex
                if (_sidebarNav.bottomCurrentIndex >= 0)
                    return _sidebarNav.count + _sidebarNav.bottomCurrentIndex
                return 0
            }

            onChildrenChanged: _sync()
            on_CurrentIdxChanged: _sync()

            function _sync() {
                for (var i = 0; i < children.length; i++)
                    children[i].visible = (i === _currentIdx)
            }
        }
    }

    // ── 边缘缩放处理 ──
    MouseArea {
        id: resizeArea
        anchors.fill: parent
        hoverEnabled: root.resizable
        acceptedButtons: Qt.NoButton
        cursorShape: {
            if (!root.resizable || _p.maximized) return Qt.ArrowCursor
            var e = PTheme.windowResizeEdge + _p.shadowSize
            var mx = mouseX, my = mouseY
            var w = width, h = height
            if (mx < e && my < e) return Qt.SizeFDiagCursor
            if (mx > w - e && my > h - e) return Qt.SizeFDiagCursor
            if (mx > w - e && my < e) return Qt.SizeBDiagCursor
            if (mx < e && my > h - e) return Qt.SizeBDiagCursor
            if (mx < e || mx > w - e) return Qt.SizeHorCursor
            if (my < e || my > h - e) return Qt.SizeVerCursor
            return Qt.ArrowCursor
        }
        z: -1
    }
}
