import QtQuick
import QtQuick.Layouts
import PigeonUI

PWindow {
    id: root
    width: 700
    height: 500
    windowTitle: qsTr("Dialog Examples")

    pages: [
        ColumnLayout {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: qsTr("弹窗组件示例")
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                Layout.alignment: Qt.AlignHCenter
            }

            RowLayout {
                spacing: PTheme.spacingMd
                Layout.alignment: Qt.AlignHCenter

                PButton {
                    text: qsTr("打开 Dialog")
                    onClicked: exampleDialog.open()
                }

                PButton {
                    text: qsTr("打开 Drawer")
                    onClicked: exampleDrawer.open()
                }
            }
        }
    ]

    PDialog {
        id: exampleDialog
        title: qsTr("示例对话框")
        message: qsTr("这是一个 PDialog 示例。")
        closeOnOverlay: true
        onConfirmed: console.log("Dialog confirmed")
        onCancelled: console.log("Dialog cancelled")
    }

    PDrawer {
        id: exampleDrawer
        width: 300

        Column {
            anchors.fill: parent
            anchors.margins: PTheme.spacingLg
            spacing: PTheme.spacingMd

            Text {
                text: qsTr("Drawer 内容")
                font.pixelSize: PTheme.fontSizeLg
                color: PTheme.colorTextPrimary
            }

            PDivider {}

            Text {
                text: qsTr("这是一个侧边抽屉示例。")
                color: PTheme.colorTextSecondary
                font.pixelSize: PTheme.fontSizeMd
            }
        }
    }
}
