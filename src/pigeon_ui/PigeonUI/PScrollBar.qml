import QtQuick
import QtQuick.Templates as T
import PigeonUI

T.ScrollBar {
    id: root

    // ── 公开属性 ──
    property bool autoHide: true
    property int showDelay: 0
    property int hideDelay: 1000

    Accessible.role: Accessible.ScrollBar
    Accessible.name: root.horizontal ? qsTr("Horizontal scroll bar") : qsTr("Vertical scroll bar")

    // ── 尺寸 ──
    implicitWidth:  root.horizontal ? 200 : _p.currentWidth + PTheme.scrollBarPadding * 2
    implicitHeight: root.horizontal ? _p.currentWidth + PTheme.scrollBarPadding * 2 : 200

    padding: PTheme.scrollBarPadding
    minimumSize: PTheme.scrollBarMinLength / (root.horizontal ? root.width : root.height)

    visible: root.autoHide ? _p.showBar : true
    opacity: root.autoHide ? _p.barOpacity : 1.0

    // ── 私有状态 ──
    QtObject {
        id: _p
        readonly property int currentWidth: root.hovered || root.pressed
            ? PTheme.scrollBarWidthHover
            : PTheme.scrollBarWidth
        property real barOpacity: 0.0
        property bool showBar: false
    }

    // ── 自动隐藏动画 ──
    Timer {
        id: _hideTimer
        interval: root.hideDelay
        onTriggered: _p.barOpacity = 0.0
    }

    onPositionChanged: {
        if (root.autoHide && root.size < 1.0) {
            _p.showBar = true
            _p.barOpacity = 1.0
            _hideTimer.restart()
        }
    }

    onSizeChanged: {
        if (root.autoHide) {
            if (root.size >= 1.0) {
                _p.showBar = false
                _p.barOpacity = 0.0
            }
        }
    }

    onPressedChanged: {
        if (root.autoHide) {
            if (root.pressed) {
                _hideTimer.stop()
                _p.barOpacity = 1.0
            } else {
                _hideTimer.restart()
            }
        }
    }

    onHoveredChanged: {
        if (root.autoHide) {
            if (root.hovered) {
                _hideTimer.stop()
                _p.barOpacity = 1.0
            } else if (!root.pressed) {
                _hideTimer.restart()
            }
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
    }

    // ── 滑块 ──
    contentItem: Rectangle {
        implicitWidth:  root.horizontal ? 0 : _p.currentWidth
        implicitHeight: root.horizontal ? _p.currentWidth : 0
        radius: _p.currentWidth / 2
        color: {
            if (root.pressed) return PTheme.scrollBarPressedColor
            if (root.hovered) return PTheme.scrollBarHoverColor
            return PTheme.scrollBarColor
        }

        Behavior on color {
            ColorAnimation { duration: PTheme.animFast }
        }

        Behavior on implicitWidth {
            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
        }

        Behavior on implicitHeight {
            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
        }
    }

    // ── 背景（仅 hover 时可见）──
    background: Rectangle {
        implicitWidth:  root.horizontal ? 0 : _p.currentWidth + PTheme.scrollBarPadding * 2
        implicitHeight: root.horizontal ? _p.currentWidth + PTheme.scrollBarPadding * 2 : 0
        color: root.hovered || root.pressed ? PTheme.colorStateSubtle : "transparent"
        radius: _p.currentWidth / 2 + PTheme.scrollBarPadding

        Behavior on color {
            ColorAnimation { duration: PTheme.animFast }
        }

        Behavior on implicitWidth {
            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
        }

        Behavior on implicitHeight {
            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
        }
    }
}
