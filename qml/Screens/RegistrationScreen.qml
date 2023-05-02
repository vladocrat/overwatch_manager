import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import ApplicationSettings 1.0
import Controls 1.0

Item {
    id: root

    signal backClicked();
    signal registerClicked();
    //ro make window dragable by DraggableItem
    signal moved();

    QtObject {
        id: internal

        property bool regInputFocused: false

        function registration() {
            //check
        }
    }

    onVisibleChanged: {
        if (root.visible)
            root.forceActiveFocus();
    }

    Keys.onEscapePressed: {
        root.backClicked();
    }

    Keys.onPressed: {
        if (!registrationInput.focus && !internal.regInputFocused) {
            registrationInput.forceActiveFocus();
            internal.regInputFocused = true;
        }
    }

    //basically enter
    Keys.onReturnPressed: {
        registrationButton.clicked();
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

    DraggableItem {
        id: header

        width: root.width
        height: root.height / 3 - backButton.height
        anchors.top: backButton.bottom

        target: root

        onPositionChanged: {
            root.moved();
        }

        Text {
            anchors.centerIn: parent

            text: "Registration"
            font.pixelSize: 35
            font.family: AppSettings.fontFamily
        }

    }

    ColumnLayout {
        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            spacing: 50

            RegistrationInput {
                id: registrationInput

                Layout.minimumHeight: 50
                Layout.minimumWidth: 200
                Layout.alignment: Qt.AlignCenter
            }

            RoundCornersButton {
                id: registrationButton

                Layout.minimumHeight: 50
                Layout.minimumWidth: 250
                Layout.alignment: Qt.AlignCenter

                label.text: "Register"

                onClicked: {
                    internal.registration();
                    root.registerClicked();
                    root.backClicked();
                }
            }
        }

        Item {
            Layout.minimumHeight: 20
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            spacing: 0

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true

                Text {
                    anchors.centerIn: parent

                    text: "Enter the code recieved from the bot"
                    font.pixelSize: 20
                    font.family: AppSettings.fontFamily

                    CustomToolTip {
                        id: toolTip

                        visible: false
                        delay: 500

                        contentItem: Text {
                            text: "To recieve the code <b>DM</b> the bot \">register\""
                            color: "#bfbaba"
                            font.family: AppSettings.fontFamily
                            font.pixelSize: 14
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onEntered: {
                        toolTip.open();
                    }

                    onExited: {
                        toolTip.hide();
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}

