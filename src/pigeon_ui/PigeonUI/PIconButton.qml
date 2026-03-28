import QtQuick
import QtQuick.Templates as T
import PigeonUI

T.Button {
    id: root

    // ── 公开属性 ──
    property string iconName: ""
    property url iconSource: ""
    property int iconSize: PTheme.iconSizeLg
    property color iconColor: PTheme.colorTextPrimary
    property bool flatStyle: true
    property color accentColor: PTheme.colorAccent
    property int size: PTheme.controlHeight

    Accessible.name: root.iconName || qsTr("Button")
    activeFocusOnTab: root.enabled

    // ── 尺寸 ──
    implicitWidth: root.size
    implicitHeight: root.size
    padding: 0

    // ── 内容 ──
    contentItem: PIcon {
        name: root.iconName
        source: root.iconSource
        size: root.iconSize
        color: {
            if (!root.enabled) return PTheme.colorTextDisabled
            return root.hovered ? root.accentColor : root.iconColor
        }

        Behavior on color {
            ColorAnimation { duration: PTheme.animFast }
        }
    }

    // ── 背景 ──
    background: Rectangle {
        radius: PTheme.radiusSm
        color: {
            if (!root.enabled) return "transparent"
            if (root.down) return PTheme.colorStatePressed
            if (root.hovered) return PTheme.colorStateHover
            return root.flatStyle ? "transparent" : PTheme.colorSurfaceAlt
        }

        Behavior on color {
            ColorAnimation { duration: PTheme.animFast }
        }

        Rectangle {
            anchors.fill: parent
            anchors.margins: -2
            radius: parent.radius + 2
            color: "transparent"
            border.width: root.visualFocus ? 2 : 0
            border.color: PTheme.colorFocusRing
        }
    }

    // ── 按压缩放 ──
    scale: root.down ? 0.92 : 1.0
    Behavior on scale {
        NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
    }

    // ── 光标 ──
    hoverEnabled: true
    HoverHandler {
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
