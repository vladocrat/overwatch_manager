import QtQuick 2.15
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.15

DraggableItem {
    id: root

    signal backClicked();

    Keys.onEscapePressed: {
        root.backClicked();
    }

    onVisibleChanged:  {
        if (root.visible) {
            root.focus = true;
        }
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
                anchors.centerIn: parent

                text: "What is a discord id?"
                font.pixelSize: 35
                font.family: "Helvetica Neue"
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Text {
                anchors.centerIn: parent

                text: "What is a discord id?"
                font.pixelSize: 20
                font.family: "Helvetica Neue"
            }
        }
    }
}
