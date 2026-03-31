import QtQuick
import PigeonUI

Rectangle {
    id: root

    // ── 公开属性 ──
    property string title: ""
    property string subtitle: ""
    property bool headerVisible: title !== "" || subtitle !== ""
    default property alias content: _contentArea.data
    property alias footer: _footerArea.data
    property bool footerVisible: false
    property int padding: PTheme.spacingMd

    // ── 尺寸 ──
    implicitWidth: 320
    implicitHeight: _layout.implicitHeight + root.padding * 2

    Accessible.role: Accessible.Pane
    Accessible.name: root.title || qsTr("Card")

    // ── 外观 ──
    color: PTheme.colorSurface
    radius: PTheme.radiusLg
    border.width: PTheme.borderWidth
    border.color: PTheme.colorBorder

    Column {
        id: _layout
        anchors {
            fill: parent
            margins: root.padding
        }
        spacing: PTheme.spacingSm

        // ── 头部 ──
        Column {
            id: _header
            width: parent.width
            spacing: PTheme.spacingXxs
            visible: root.headerVisible

            Text {
                text: root.title
                font.pixelSize: PTheme.fontSizeLg
                font.bold: true
                color: PTheme.colorTextPrimary
                width: parent.width
            }

            Text {
                text: root.subtitle
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                width: parent.width
                visible: text !== ""
            }
        }

        // ── 分割线 ──
        Rectangle {
            width: parent.width
            height: PTheme.borderWidth
            color: PTheme.colorDivider
            visible: root.headerVisible && _contentArea.children.length > 0
        }

        // ── 内容区 ──
        Item {
            id: _contentArea
            width: parent.width
            implicitHeight: childrenRect.height
        }

        // ── 底部分割线 ──
        Rectangle {
            width: parent.width
            height: PTheme.borderWidth
            color: PTheme.colorDivider
            visible: root.footerVisible
        }

        // ── 底部区 ──
        Item {
            id: _footerArea
            width: parent.width
            implicitHeight: childrenRect.height
            visible: root.footerVisible
        }
    }
}
