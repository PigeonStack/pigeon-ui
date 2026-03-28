import QtQuick
import QtQuick.Templates as T
import PigeonUI

T.Switch {
    id: root

    // ── 公开属性 ──
    property color accentColor: PTheme.colorAccent

    Accessible.role: Accessible.Button
    Accessible.name: root.checked ? qsTr("On") : qsTr("Off")
    activeFocusOnTab: root.enabled

    // ── 尺寸 ──
    implicitWidth: PTheme.controlSwitchWidth
    implicitHeight: PTheme.controlSwitchHeight

    // ── 滑块 ──
    indicator: Rectangle {
        id: _track
        width: root.implicitWidth
        height: root.implicitHeight
        radius: height / 2
        color: root.checked
            ? root.accentColor
            : (root.hovered ? Qt.lighter(PTheme.colorSurfaceAlt, 1.3) : PTheme.colorSurfaceAlt)
        border.width: root.checked ? 0 : PTheme.borderWidth
        border.color: root.hovered ? PTheme.colorTextSecondary : PTheme.colorBorder

        Behavior on color {
            ColorAnimation { duration: PTheme.animFast }
        }
        Behavior on border.color {
            ColorAnimation { duration: PTheme.animFast }
        }

        Rectangle {
            id: _thumb
            width: PTheme.controlSwitchThumb
            height: PTheme.controlSwitchThumb
            radius: PTheme.controlSwitchThumb / 2
            anchors.verticalCenter: parent.verticalCenter
            x: root.checked ? parent.width - width - (parent.height - PTheme.controlSwitchThumb) / 2
                            : (parent.height - PTheme.controlSwitchThumb) / 2
            color: root.enabled ? PTheme.colorTextPrimary : PTheme.colorTextDisabled
            scale: root.down ? 0.9 : 1.0

            Behavior on x {
                NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
            }
            Behavior on scale {
                NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
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

    // ── 光标 ──
    hoverEnabled: true
    HoverHandler {
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
