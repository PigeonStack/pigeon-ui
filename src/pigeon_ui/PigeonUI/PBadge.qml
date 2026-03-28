import QtQuick
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property int count: 0
    property bool showZero: false
    property int maxCount: 99
    property bool dot: false                       // 仅显示小圆点
    property color badgeColor: PTheme.colorError
    property color textColor: PTheme.colorOnAccent

    Accessible.role: Accessible.Indicator
    Accessible.name: root.dot ? qsTr("Notification") : root.count.toString()

    // ── 内容 ──
    default property alias content: _anchor.data

    // ── 尺寸跟随内容 ──
    implicitWidth: _anchor.childrenRect.width
    implicitHeight: _anchor.childrenRect.height

    Item {
        id: _anchor
        width: root.implicitWidth
        height: root.implicitHeight
    }

    // ── 小圆点模式 ──
    Rectangle {
        id: _dot
        visible: root.dot && (root.count > 0 || root.showZero)
        width: PTheme.controlDotSize
        height: PTheme.controlDotSize
        radius: PTheme.controlDotSize / 2
        color: root.badgeColor
        anchors.top: _anchor.top
        anchors.right: _anchor.right
        anchors.topMargin: -2
        anchors.rightMargin: -2
        z: 1

        Behavior on visible {
            enabled: false
        }

        scale: visible ? 1.0 : 0.0
        Behavior on scale {
            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutBack }
        }
    }

    // ── 数字标签模式 ──
    Rectangle {
        id: _badge
        visible: !root.dot && (root.count > 0 || root.showZero)
        height: PTheme.controlIndicatorSize
        width: Math.max(height, _label.implicitWidth + PTheme.spacingSm)
        radius: height / 2
        color: root.badgeColor
        anchors.top: _anchor.top
        anchors.right: _anchor.right
        anchors.topMargin: -height / 3
        anchors.rightMargin: -width / 3
        z: 1

        scale: visible ? 1.0 : 0.0
        Behavior on scale {
            NumberAnimation { duration: PTheme.animFast; easing.type: Easing.OutBack }
        }

        Text {
            id: _label
            anchors.centerIn: parent
            text: root.count > root.maxCount ? (root.maxCount + "+") : root.count.toString()
            font.pixelSize: PTheme.fontSizeXs
            font.bold: true
            color: root.textColor
        }
    }
}
