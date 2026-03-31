import QtQuick
import QtQuick.Templates as T
import PigeonUI

T.Slider {
    id: root

    // ── 公开属性 ──
    property color accentColor: PTheme.colorAccent
    property bool showValue: false

    Accessible.role: Accessible.Slider
    Accessible.name: qsTr("Slider")
    activeFocusOnTab: root.enabled

    // ── 尺寸 ──
    implicitWidth: root.horizontal ? 200 : PTheme.sliderThumbSize
    implicitHeight: root.horizontal ? PTheme.sliderThumbSize : 200

    padding: 0

    // ── 私有状态 ──
    QtObject {
        id: _p
        readonly property bool horizontal: root.horizontal
    }

    // ── 背景轨道 ──
    background: Item {
        x: root.horizontal ? 0 : (root.width - width) / 2
        y: root.horizontal ? (root.height - height) / 2 : 0
        width: root.horizontal ? root.availableWidth : PTheme.sliderTrackHeight
        height: root.horizontal ? PTheme.sliderTrackHeight : root.availableHeight

        Rectangle {
            anchors.fill: parent
            radius: PTheme.sliderTrackHeight / 2
            color: PTheme.sliderTrackColor
        }

        Rectangle {
            width: root.horizontal
                ? root.visualPosition * parent.width
                : parent.width
            height: root.horizontal
                ? parent.height
                : (1.0 - root.visualPosition) * parent.height
            y: root.horizontal ? 0 : root.visualPosition * parent.height
            radius: PTheme.sliderTrackHeight / 2
            color: root.enabled ? root.accentColor : PTheme.colorTextDisabled

            Behavior on width {
                enabled: !root.pressed
                NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
            }
            Behavior on height {
                enabled: !root.pressed
                NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
            }
        }
    }

    // ── 滑块 ──
    handle: Rectangle {
        x: root.horizontal
            ? root.leftPadding + root.visualPosition * (root.availableWidth - width)
            : (root.width - width) / 2
        y: root.horizontal
            ? (root.height - height) / 2
            : root.topPadding + root.visualPosition * (root.availableHeight - height)
        width: PTheme.sliderThumbSize
        height: PTheme.sliderThumbSize
        radius: PTheme.sliderThumbSize / 2
        color: root.enabled ? root.accentColor : PTheme.colorTextDisabled
        border.width: root.pressed ? 0 : 2
        border.color: Qt.lighter(root.accentColor, 1.3)
        scale: root.pressed ? 1.15 : (root.hovered ? 1.08 : 1.0)

        Behavior on scale {
            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
        }
        Behavior on border.width {
            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutCubic }
        }

        // ── 焦点环 ──
        Rectangle {
            anchors.fill: parent
            anchors.margins: -3
            radius: parent.radius + 3
            color: "transparent"
            border.width: root.visualFocus ? 2 : 0
            border.color: PTheme.colorFocusRing
        }

        // ── 值标签 ──
        Rectangle {
            visible: root.showValue && root.pressed
            width: _valText.implicitWidth + PTheme.spacingSm * 2
            height: _valText.implicitHeight + PTheme.spacingXs * 2
            radius: PTheme.radiusSm
            color: PTheme.colorSurface
            border.width: PTheme.borderWidth
            border.color: PTheme.colorBorder
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: PTheme.spacingXs

            Text {
                id: _valText
                anchors.centerIn: parent
                text: root.value.toFixed(root.stepSize < 1 ? 1 : 0)
                font.pixelSize: PTheme.fontSizeXs
                color: PTheme.colorTextPrimary
            }
        }
    }

    // ── 光标 ──
    hoverEnabled: true
    HoverHandler {
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
