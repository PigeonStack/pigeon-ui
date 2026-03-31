import QtQuick
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property var model: []              // ["text"] or [{text, icon, subtitle}]
    property bool showDivider: true
    property int itemHeight: 40

    // ── 信号 ──
    signal itemClicked(int index)

    // ── 尺寸 ──
    implicitWidth: 280
    implicitHeight: _list.contentHeight

    Accessible.role: Accessible.List
    Accessible.name: qsTr("List")

    ListView {
        id: _list
        anchors.fill: parent
        model: root.model
        clip: true
        interactive: contentHeight > height

        delegate: Item {
            id: _delegate
            width: _list.width
            height: root.itemHeight

            required property int index
            required property var modelData

            Accessible.role: Accessible.ListItem
            Accessible.name: _delegate.itemText

            property string itemText: {
                if (typeof modelData === "string") return modelData
                if (modelData && modelData.text !== undefined) return modelData.text
                return ""
            }
            property string itemIcon: {
                if (typeof modelData === "object" && modelData && modelData.icon !== undefined) return modelData.icon
                return ""
            }
            property string itemSubtitle: {
                if (typeof modelData === "object" && modelData && modelData.subtitle !== undefined) return modelData.subtitle
                return ""
            }

            Rectangle {
                anchors.fill: parent
                radius: PTheme.radiusSm
                color: {
                    if (_ma.pressed) return PTheme.colorStatePressed
                    if (_ma.containsMouse) return PTheme.colorStateHover
                    return "transparent"
                }

                Behavior on color {
                    ColorAnimation { duration: PTheme.animFast }
                }
            }

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: PTheme.spacingSm
                anchors.rightMargin: PTheme.spacingSm
                spacing: PTheme.spacingSm

                PIcon {
                    visible: _delegate.itemIcon !== ""
                    name: _delegate.itemIcon
                    size: PTheme.iconSizeMd
                    color: PTheme.colorTextSecondary
                    anchors.verticalCenter: parent.verticalCenter
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: PTheme.spacingXxs

                    Text {
                        text: _delegate.itemText
                        font.pixelSize: PTheme.fontSizeMd
                        color: _ma.containsMouse ? PTheme.colorTextPrimary : PTheme.colorTextSecondary

                        Behavior on color {
                            ColorAnimation { duration: PTheme.animFast }
                        }
                    }

                    Text {
                        visible: _delegate.itemSubtitle !== ""
                        text: _delegate.itemSubtitle
                        font.pixelSize: PTheme.fontSizeSm
                        color: PTheme.colorTextDisabled
                    }
                }
            }

            // ── 分割线 ──
            Rectangle {
                visible: root.showDivider && index < root.model.length - 1
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: PTheme.spacingSm
                anchors.rightMargin: PTheme.spacingSm
                height: PTheme.borderWidth
                color: PTheme.colorDivider
            }

            MouseArea {
                id: _ma
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.itemClicked(index)
            }
        }
    }
}
