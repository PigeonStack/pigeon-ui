import QtQuick
import QtQuick.Templates as T
import PigeonUI

T.CheckBox {
    id: root

    // ── 公开属性 ──
    property color accentColor: PTheme.colorAccent

    // ── 内部状态 ──
    QtObject {
        id: _p

        property color boxBorder: {
            if (!root.enabled) return PTheme.colorTextDisabled
            if (root.checked)  return root.accentColor
            if (root.hovered)  return PTheme.colorTextSecondary
            return PTheme.colorBorder
        }

        property color boxBg: root.checked ? root.accentColor : "transparent"
    }

    Accessible.role: Accessible.CheckBox
    Accessible.name: root.text
    activeFocusOnTab: root.enabled

    // ── 尺寸 ──
    implicitWidth: contentItem.implicitWidth + leftPadding + rightPadding
    implicitHeight: Math.max(PTheme.controlIndicatorSize, contentItem.implicitHeight)
    spacing: PTheme.spacingSm
    leftPadding: 0
    rightPadding: 0

    // ── 指示器 ──
    indicator: Rectangle {
        width: PTheme.controlIndicatorSize
        height: PTheme.controlIndicatorSize
        radius: PTheme.radiusSm
        anchors.verticalCenter: parent.verticalCenter
        color: _p.boxBg
        border.width: root.checked ? 0 : PTheme.borderWidth
        border.color: _p.boxBorder

        Behavior on color {
            ColorAnimation { duration: PTheme.animFast }
        }
        Behavior on border.color {
            ColorAnimation { duration: PTheme.animFast }
        }

        PIcon {
            anchors.centerIn: parent
            name: "checkmark"
            size: PTheme.iconSizeSm
            color: PTheme.colorTextPrimary
            scale: root.checked ? 1.0 : 0.0

            Behavior on scale {
                NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutBack }
            }
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

    // ── 内容 ──
    contentItem: Text {
        text: root.text
        font.pixelSize: PTheme.fontSizeMd
        color: root.enabled ? PTheme.colorTextPrimary : PTheme.colorTextDisabled
        leftPadding: root.indicator.width + root.spacing
        verticalAlignment: Text.AlignVCenter

        Behavior on color {
            ColorAnimation { duration: PTheme.animFast }
        }
    }

    // ── 光标 ──
    hoverEnabled: true
    HoverHandler {
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
