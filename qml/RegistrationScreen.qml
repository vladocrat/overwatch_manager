import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

DraggableItem {
    id: root

    signal backClicked();

    ArrowButton {
        id: backButton

        width: 80
        height: 40

        anchors.left: root.left
        anchors.top: root.top

        onClicked: {
            root.backClicked();
        }
    }

    ColumnLayout {
        width: root.width
        height: root.height - backButton.height
        anchors.top: backButton.bottom

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Text {
                anchors.centerIn: parent

                text: "Registration"
                font.pixelSize: 35
                font.family: "Helvetica Neue"
            }
        }

        CustomToolTip {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            popup: Popup {
                id: info

                width: 60
                height: 70
                contentItem: Text {
                    textFormat: Text.RichText
                    text: qsTr("To recieve the code <b>DM</b> the bot \">register\"")
                }
            }

            contentItem: Rectangle {
                anchors.fill: parent
                border.width: 2
                Component.onCompleted: console.log(width + " " + height)

                Text {
                    anchors.fill: parent
                    text: "testText"
                    font.pixelSize: 20
                    font.family: "Helvetica Neue"
                }
            }
        }

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            spacing: 0

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter

                Text {
                    anchors.centerIn: parent

                    text: "Enter the code recieved from the bot"
                    font.pixelSize: 20
                    font.family: "Helvetica Neue"
                }
            }
        }
    }
}
