import QtQuick 2.15
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.15
import ApplicationSettings 1.0

DraggableItem {
    id: root

    signal backClicked();

    property alias header: header
    property alias content: content
    property alias imgage: image
    property alias imageTranscription: imageTranscription

    onVisibleChanged: {
        if (root.visible)
            root.forceActiveFocus();
    }

    Keys.onEscapePressed: {
        root.backClicked();
    }

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
            Layout.fillWidth: true
            Layout.minimumHeight: 10
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Text {
                id: header

                anchors.centerIn: parent

                text: "What is a discord id?"
                font.pixelSize: 35
                font.family: AppSettings.fontFamily
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Text {
                id: content

                anchors.centerIn: parent

                width: parent.width
                height: parent.height
                leftPadding: 20

                lineHeight: 1.5
                wrapMode: Text.Wrap
                textFormat: Text.RichText
                text: "Discord id is a unique way for discord to identify you!<br>It consists of your nickname and 4 digits<br>Your discord id can be found in the settings<br>or at the bottom left corner just near your name."
                font.pixelSize: 15
                font.family: AppSettings.fontFamily
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Image {
                id: image

                anchors.centerIn: parent

                width: parent.width / 2
                height: parent.height / 2
                source: "sources/images/discord_id_example.jpg"
            }
        }

        Item {
            Layout.minimumHeight: 30
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Text {
                id: imageTranscription

                anchors.centerIn: parent

                font.pixelSize: 15
                font.family: AppSettings.fontFamily
                text: "In this case full discord id is: Sherlock#0238"
            }
        }
    }
}
