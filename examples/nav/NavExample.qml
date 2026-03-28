import QtQuick
import QtQuick.Layouts
import PigeonUI

PWindow {
    id: root
    width: 800
    height: 500
    title: qsTr("Navigation Examples")

    pages: [
        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // PTabBar
            PTabBar {
                id: tabBar
                Layout.fillWidth: true
                model: [
                    { text: qsTr("首页") },
                    { text: qsTr("组件") },
                    { text: qsTr("设置") }
                ]
            }

            PDivider {}

            // PBreadcrumb
            PBreadcrumb {
                Layout.leftMargin: PTheme.spacingLg
                Layout.topMargin: PTheme.spacingMd
                model: [
                    { text: qsTr("首页") },
                    { text: qsTr("组件库") },
                    { text: qsTr("导航") }
                ]
            }

            // 内容区域
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text {
                    anchors.centerIn: parent
                    text: qsTr("当前 Tab 索引: %1").arg(tabBar.currentIndex)
                    font.pixelSize: PTheme.fontSizeLg
                    color: PTheme.colorText
                }
            }
        }
    ]
}
