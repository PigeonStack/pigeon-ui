import QtQuick
import QtQuick.Templates as T
import PigeonUI

T.ToolTip {
    id: root

    // ── 公开属性 ──
    property int showDelay: 600
    property int hideDelay: 200

    delay: root.showDelay
    timeout: 4000

    // ── 内容 ──
    contentItem: Text {
        text: root.text
        font.pixelSize: PTheme.fontSizeSm
        color: PTheme.colorTextPrimary
        wrapMode: Text.WordWrap
    }

    // ── 背景 ──
    background: Rectangle {
        color: PTheme.colorSurfaceAlt
        radius: PTheme.radiusSm
        border.width: PTheme.borderWidth
        border.color: PTheme.colorBorder

        layer.enabled: true
        layer.effect: Item {}   // placeholder — shadow via DropShadow if Qt Quick Effects available
    }

    // ── 内边距 ──
    leftPadding: PTheme.spacingSm
    rightPadding: PTheme.spacingSm
    topPadding: PTheme.spacingXs
    bottomPadding: PTheme.spacingXs

    // ── 动画 ──
    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: PTheme.animFast; easing.type: Easing.OutCubic }
    }
    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: PTheme.animFast; easing.type: Easing.OutCubic }
    }
}
