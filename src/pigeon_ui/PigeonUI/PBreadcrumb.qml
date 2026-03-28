import QtQuick
import PigeonUI

Row {
    id: root

    // ── 公开属性 ──
    // model: [{ text: "Home", icon: "home" }, { text: "Settings" }, ...]
    property var model: []
    property string separatorIcon: "chevron_right"

    // ── 公开信号 ──
    signal itemClicked(int index)

    Accessible.role: Accessible.PageTabList
    Accessible.name: qsTr("Breadcrumb")

    // ── 尺寸 ──
    spacing: PTheme.spacingXs

    Repeater {
        model: root.model

        Row {
            id: _crumbRow
            required property var modelData
            required property int index
            spacing: PTheme.spacingXs

            // ── 分隔符（第一项不显示）──
            PIcon {
                visible: _crumbRow.index > 0
                name: root.separatorIcon
                size: PTheme.iconSizeXs
                color: PTheme.breadcrumbSeparatorColor
                anchors.verticalCenter: parent.verticalCenter
            }

            // ── 面包屑项 ──
            Rectangle {
                id: _itemBg
                width: _itemRow.implicitWidth + PTheme.spacingSm * 2
                height: PTheme.controlItemHeight
                radius: PTheme.radiusSm
                color: _itemMa.containsMouse ? PTheme.colorStateHover : "transparent"
                anchors.verticalCenter: parent.verticalCenter

                Behavior on color { ColorAnimation { duration: PTheme.animFast } }

                Row {
                    id: _itemRow
                    anchors.centerIn: parent
                    spacing: PTheme.spacingXs

                    PIcon {
                        visible: !!_crumbRow.modelData.icon
                        name: _crumbRow.modelData.icon || ""
                        size: PTheme.iconSizeSm
                        color: _crumbRow.index === root.model.length - 1
                            ? PTheme.colorTextPrimary
                            : (_itemMa.containsMouse ? PTheme.colorTextPrimary : PTheme.colorTextSecondary)
                        anchors.verticalCenter: parent.verticalCenter

                        Behavior on color { ColorAnimation { duration: PTheme.animFast } }
                    }

                    Text {
                        text: _crumbRow.modelData.text || ""
                        font.pixelSize: PTheme.fontSizeSm
                        font.weight: _crumbRow.index === root.model.length - 1 ? Font.DemiBold : Font.Normal
                        color: _crumbRow.index === root.model.length - 1
                            ? PTheme.colorTextPrimary
                            : (_itemMa.containsMouse ? PTheme.colorTextPrimary : PTheme.colorTextSecondary)
                        anchors.verticalCenter: parent.verticalCenter

                        Behavior on color { ColorAnimation { duration: PTheme.animFast } }
                    }
                }

                MouseArea {
                    id: _itemMa
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.itemClicked(_crumbRow.index)
                }
            }
        }
    }
}
