import QtQuick
import QtQuick.Templates as T
import PigeonUI

T.Button {
    id: root

    // ── 公开属性 ──
    property string type: "default"   // "default" | "primary" | "flat" | "outlined"
    property color accentColor: PTheme.colorAccent

    // ── 内部状态 ──
    QtObject {
        id: _p

        property color bgNormal: {
            switch (root.type) {
                case "primary":  return root.accentColor
                case "outlined": return "transparent"
                case "flat":     return "transparent"
                default:         return PTheme.colorSurfaceAlt
            }
        }

        property color bgHovered: {
            switch (root.type) {
                case "primary":  return Qt.lighter(root.accentColor, 1.12)
                case "outlined": return Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.08)
                case "flat":     return PTheme.colorStateHover
                default:         return Qt.lighter(PTheme.colorSurfaceAlt, 1.3)
            }
        }

        property color bgPressed: {
            switch (root.type) {
                case "primary":  return Qt.darker(root.accentColor, 1.15)
                case "outlined": return Qt.rgba(root.accentColor.r, root.accentColor.g, root.accentColor.b, 0.15)
                case "flat":     return PTheme.colorStatePressed
                default:         return Qt.darker(PTheme.colorSurfaceAlt, 1.2)
            }
        }

        property color bgCurrent: {
            if (!root.enabled) return "transparent"
            if (root.down)     return bgPressed
            if (root.hovered)  return bgHovered
            return bgNormal
        }

        property color textColor: {
            if (!root.enabled) return PTheme.colorTextDisabled
            switch (root.type) {
                case "primary":  return PTheme.colorTextPrimary
                case "outlined": return root.accentColor
                case "flat":     return root.accentColor
                default:         return PTheme.colorTextPrimary
            }
        }

        property color borderColor: {
            if (root.type === "outlined") {
                if (!root.enabled) return PTheme.colorTextDisabled
                return root.accentColor
            }
            if (root.type === "primary") {
                return Qt.darker(root.accentColor, 1.3)
            }
            return "transparent"
        }
    }

    Accessible.role: Accessible.Button
    Accessible.name: root.text
    activeFocusOnTab: root.enabled

    // ── 尺寸 ──
    implicitWidth: Math.max(80, contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: PTheme.controlHeight
    padding: 0
    leftPadding: PTheme.spacingMd
    rightPadding: PTheme.spacingMd

    // ── 内容 ──
    contentItem: Text {
        text: root.text
        font.pixelSize: PTheme.fontSizeMd
        color: _p.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        Behavior on color {
            ColorAnimation { duration: PTheme.animFast }
        }
    }

    // ── 背景 ──
    background: Rectangle {
        radius: PTheme.radiusSm
        color: _p.bgCurrent
        border.width: root.type === "outlined" ? 1 : 0
        border.color: _p.borderColor

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
    scale: root.down ? 0.97 : 1.0
    Behavior on scale {
        NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
    }

    // ── 光标 ──
    hoverEnabled: true
    HoverHandler {
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
