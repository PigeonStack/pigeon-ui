import QtQuick
import QtQuick.Layouts
import PigeonUI

PWindow {
    id: root
    width: 700
    height: 550
    title: qsTr("Theming Examples")

    pages: [
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: PTheme.spacingXl
            spacing: PTheme.spacingLg

            // 主题切换
            RowLayout {
                spacing: PTheme.spacingMd

                Text {
                    text: qsTr("主题模式")
                    font.pixelSize: PTheme.fontSizeLg
                    color: PTheme.colorTextPrimary
                }

                PSwitch {
                    text: PTheme.darkMode ? qsTr("深色") : qsTr("浅色")
                    checked: PTheme.darkMode
                    onCheckedChanged: PTheme.darkMode = checked
                }
            }

            PDivider {}

            // 颜色 Token 展示
            Text {
                text: qsTr("颜色 Tokens")
                font.pixelSize: PTheme.fontSizeMd
                color: PTheme.colorTextSecondary
            }

            GridLayout {
                columns: 4
                columnSpacing: PTheme.spacingMd
                rowSpacing: PTheme.spacingMd

                Repeater {
                    model: [
                        { name: "colorBg", color: PTheme.colorBg },
                        { name: "colorSurface", color: PTheme.colorSurface },
                        { name: "colorSurfaceAlt", color: PTheme.colorSurfaceAlt },
                        { name: "colorAccent", color: PTheme.colorAccent },
                        { name: "colorSuccess", color: PTheme.colorSuccess },
                        { name: "colorWarning", color: PTheme.colorWarning },
                        { name: "colorError", color: PTheme.colorError },
                        { name: "colorInfo", color: PTheme.colorInfo }
                    ]

                    delegate: ColumnLayout {
                        spacing: 4

                        Rectangle {
                            width: 80
                            height: 50
                            radius: PTheme.radiusSm
                            color: modelData.color
                            border.width: 1
                            border.color: PTheme.colorBorder
                        }

                        Text {
                            text: modelData.name
                            font.pixelSize: PTheme.fontSizeXs
                            color: PTheme.colorTextSecondary
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }

            PDivider {}

            // 组件预览
            Text {
                text: qsTr("组件在当前主题下的效果")
                font.pixelSize: PTheme.fontSizeMd
                color: PTheme.colorTextSecondary
            }

            RowLayout {
                spacing: PTheme.spacingMd

                PButton { text: qsTr("按钮") }

                PBadge { count: 3 }

                PTag { text: qsTr("标签") }

                PSpinner { }
            }

            RowLayout {
                spacing: PTheme.spacingMd

                PInput {
                    placeholderText: qsTr("输入框")
                    implicitWidth: 200
                }

                PSwitch { text: qsTr("开关") }
            }

            PProgressBar {
                value: 0.65
                Layout.fillWidth: true
            }
        }
    ]
}
