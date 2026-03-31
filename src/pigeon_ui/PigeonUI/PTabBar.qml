import QtQuick
import QtQuick.Templates as T
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property alias model: _repeater.model
    property int currentIndex: 0
    property color accentColor: PTheme.colorAccent
    property int tabHeight: PTheme.controlHeight
    property int tabMinWidth: 60

    // ── 信号 ──
    signal tabClicked(int index)

    // ── 尺寸 ──
    implicitWidth: _row.implicitWidth
    implicitHeight: tabHeight

    Accessible.role: Accessible.PageTabList
    Accessible.name: qsTr("Tabs")

    // ── 内部状态 ──
    QtObject {
        id: _p
        property int hoveredIndex: -1
    }

    // ── 底部线 ──
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: PTheme.borderWidth
        color: PTheme.colorDivider
    }

    // ── 指示条 ──
    Rectangle {
        id: _indicator
        height: PTheme.tabIndicatorHeight
        anchors.bottom: parent.bottom
        color: root.accentColor
        radius: height / 2

        // 动态定位
        property var _target: _repeater.count > 0 && root.currentIndex >= 0
            && root.currentIndex < _repeater.count
            ? _repeater.itemAt(root.currentIndex) : null

        x: _target ? _target.x : 0
        width: _target ? _target.width : 0

        Behavior on x {
            NumberAnimation { duration: PTheme.animNormal; easing.type: Easing.OutCubic }
        }
        Behavior on width {
            NumberAnimation { duration: PTheme.animNormal; easing.type: Easing.OutCubic }
        }
    }

    Row {
        id: _row
        anchors.fill: parent

        Repeater {
            id: _repeater

            delegate: T.Button {
                id: _tab
                height: root.tabHeight
                width: Math.max(root.tabMinWidth, _tabText.implicitWidth + PTheme.spacingMd * 2)

                required property int index
                required property var modelData

                Accessible.role: Accessible.PageTab
                Accessible.name: _tab.tabText

                property bool isCurrent: root.currentIndex === index
                property string tabText: {
                    if (typeof modelData === "string") return modelData
                    if (modelData && modelData.text !== undefined) return modelData.text
                    return ""
                }

                hoverEnabled: true
                onHoveredChanged: {
                    if (hovered) _p.hoveredIndex = index
                    else if (_p.hoveredIndex === index) _p.hoveredIndex = -1
                }
                onClicked: {
                    root.currentIndex = index
                    root.tabClicked(index)
                }

                contentItem: Text {
                    id: _tabText
                    text: _tab.tabText
                    font.pixelSize: PTheme.fontSizeMd
                    font.bold: _tab.isCurrent
                    color: {
                        if (_tab.isCurrent) return root.accentColor
                        if (_tab.hovered) return PTheme.colorTextPrimary
                        return PTheme.colorTextSecondary
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    Behavior on color {
                        ColorAnimation { duration: PTheme.animFast }
                    }
                }

                background: Rectangle {
                    color: {
                        if (_tab.down) return PTheme.colorStateHover
                        if (_tab.hovered) return PTheme.colorStateSubtle
                        return "transparent"
                    }

                    Behavior on color {
                        ColorAnimation { duration: PTheme.animFast }
                    }
                }

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
