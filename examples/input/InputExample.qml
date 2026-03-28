import QtQuick
import QtQuick.Layouts
import PigeonUI

PWindow {
    id: root
    width: 700
    height: 600
    title: qsTr("Input Examples")

    pages: [
        Flickable {
            anchors.fill: parent
            anchors.margins: PTheme.spacingXl
            contentHeight: mainColumn.implicitHeight
            clip: true

            ColumnLayout {
                id: mainColumn
                width: parent.width
                spacing: PTheme.spacingLg

                Text {
                    text: qsTr("数据录入组件示例")
                    font.pixelSize: PTheme.fontSizeXl
                    color: PTheme.colorTextPrimary
                }

                PDivider {}

                // PInput
                Text {
                    text: "PInput"
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextSecondary
                }

                PInput {
                    placeholderText: qsTr("请输入文本...")
                    Layout.preferredWidth: 300
                }

                PDivider {}

                // PCheckbox & PRadio
                Text {
                    text: "PCheckbox & PRadio"
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextSecondary
                }

                RowLayout {
                    spacing: PTheme.spacingLg

                    PCheckbox { text: qsTr("选项 A") }
                    PCheckbox { text: qsTr("选项 B"); checked: true }
                    PRadio { text: qsTr("单选 1") }
                    PRadio { text: qsTr("单选 2") }
                }

                PDivider {}

                // PSwitch
                Text {
                    text: "PSwitch"
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextSecondary
                }

                PSwitch {
                    text: qsTr("启用通知")
                }

                PDivider {}

                // PSlider
                Text {
                    text: "PSlider"
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextSecondary
                }

                PSlider {
                    Layout.preferredWidth: 300
                    showValue: true
                }

                PDivider {}

                // PTextarea
                Text {
                    text: "PTextarea"
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextSecondary
                }

                PTextarea {
                    placeholderText: qsTr("请输入多行文本...")
                    Layout.preferredWidth: 400
                    Layout.preferredHeight: 120
                }
            }
        }
    ]
}
