import QtQuick
import PigeonUI

Rectangle {
    id: root

    // ── 公开属性 ──
    property string source: ""
    property string text: ""
    property string iconName: ""
    property int size: PTheme.avatarSizeMd
    property color bgColor: PTheme.avatarBgColor
    property color textColor: PTheme.colorTextPrimary

    Accessible.role: Accessible.StaticText
    Accessible.name: root.text || qsTr("Avatar")

    // ── 尺寸 ──
    implicitWidth: root.size
    implicitHeight: root.size
    width: root.size
    height: root.size
    radius: root.size / 2
    color: root.bgColor
    clip: true

    // ── 私有状态 ──
    QtObject {
        id: _p
        readonly property bool hasImage: root.source !== ""
        readonly property bool hasText: root.text !== ""
        readonly property bool hasIcon: root.iconName !== ""
        readonly property string initials: {
            if (!root.text) return ""
            var parts = root.text.trim().split(/\s+/)
            if (parts.length >= 2)
                return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase()
            return parts[0].substring(0, 2).toUpperCase()
        }
    }

    // ── 图片模式 ──
    Image {
        id: _image
        anchors.fill: parent
        source: root.source
        fillMode: Image.PreserveAspectCrop
        visible: _p.hasImage && status === Image.Ready
        layer.enabled: true
        layer.effect: Item {
            // 圆形裁剪通过 parent clip 实现
        }
    }

    // ── 文字模式（initials）──
    Text {
        id: _initials
        anchors.centerIn: parent
        visible: !_image.visible && _p.hasText
        text: _p.initials
        font.pixelSize: root.size * 0.38
        font.weight: Font.DemiBold
        color: root.textColor
    }

    // ── 图标模式 ──
    PIcon {
        id: _icon
        anchors.centerIn: parent
        visible: !_image.visible && !_p.hasText && _p.hasIcon
        name: root.iconName
        size: root.size * 0.5
        color: root.textColor
    }

    // ── 回退模式（默认 person 图标）──
    PIcon {
        anchors.centerIn: parent
        visible: !_image.visible && !_p.hasText && !_p.hasIcon
        name: "person"
        size: root.size * 0.5
        color: root.textColor
    }
}
