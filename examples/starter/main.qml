import QtQuick
import PigeonUI

PWindow {
    id: root
    width: 600
    height: 400
    title: qsTr("PigeonUI Starter")

    pages: [
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: qsTr("Welcome to PigeonUI!")
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter

                PButton {
                    text: qsTr("Primary")
                }

                PButton {
                    text: qsTr("Toggle Theme")
                    onClicked: PTheme.darkMode = !PTheme.darkMode
                }
            }

            PSwitch {
                text: qsTr("Dark Mode")
                checked: PTheme.darkMode
                onCheckedChanged: PTheme.darkMode = checked
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    ]
}
