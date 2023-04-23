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

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            border.width: 1

            MouseArea {
                id: ma

                anchors.fill: parent
                ToolTip.visible: false;
                ToolTip.text: "text"

                onEntered: {
                    ToolTip.visible = true;
                }

                onExited: {
                    ToolTip.visible = false;
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

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        ToolTip.visible: false
                        ToolTip.text: "To recieve the code <b>DM</b> the bot \">register\""

                        onEntered: {
                            ToolTip.visible = true;
                        }

                        onExited: {
                            ToolTip.visible = false;
                        }
                    }
                }
            }
        }
    }
}
