import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.1
import FPSText 1.0
import ApplicationSettings 1.0

Item {
    id: root

    signal loginClicked();
    //info about discord id
    signal idInfoCliked();
    //registration required
    signal noAccountClicked();
    //to make window dragable by DraggableItem
    signal moved();

    DraggableItem {
        id: rec

        property int currentIndex: 0 //TODO randomize
        property var words: ["Welcome!", "こにちは!", "Salut!", "Bonjour!", "환영!", "欢迎!", "Välkommen!"]

        width: root.width
        height: root.height * 0.4
        target: root

        onPositionChanged: {
            root.moved();
        }

        RowLayout {
            spacing: 0
            anchors.centerIn: parent

            Text {
                id: text
                text: ""
                font.family: AppSettings.fontFamily
                font.pixelSize: 30

                onTextChanged: {
                    cursor.visible = true
                    cursor.x = x + width
                }
            }

            Rectangle {
                id: cursor
                width: 2
                height: text.font.pixelSize
                color: "black"
                visible: false

                NumberAnimation {
                    target: cursor
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 500
                    loops: Animation.Infinite
                    running: true
                }
            }
        }

        Timer {
            id: timer
        }

        SequentialAnimation {
            id: typingAnimation
            running: true
            alwaysRunToEnd: false

            PropertyAction {
                target: text
                property: "text"
            }

            ScriptAction {
                script: {
                    var i = 0;

                    if (rec.currentIndex >= rec.words.length) {
                        rec.currentIndex = 0;
                    }

                    var word = rec.words[rec.currentIndex];
                    rec.currentIndex++;
                    timer.interval = 200;
                    timer.repeat = true;

                    //TODO move to timer obj trigger handler
                    timer.triggered.connect(function() {
                        text.text += word.charAt(i);
                        i++;
                        if (i === word.length) {
                            timer.stop();
                        }
                    });

                    timer.start();
                }
            }

            PauseAnimation {
                duration: 2000
            }

            ScriptAction {
                script: {
                    typingAnimation.stop();
                    if (!typingAnimation.running)
                        deleteAnimation.restart();
                }
            }
        }

        Timer {
            id: deleteTimer

            onTriggered: {
                text.text = text.text.slice(0, -1);

                if (text.text.length === 0) {
                    deleteTimer.stop();
                }
            }
        }

        SequentialAnimation {
            id: deleteAnimation
            running: false

            PropertyAction {
                target: text
                property: "text"
            }

            ScriptAction {
                script: {
                    deleteTimer.interval = 150;
                    deleteTimer.repeat = true;
                    deleteTimer.start();
                }
            }

            PauseAnimation {
                duration: 1300
            }

            ScriptAction {
                script: {
                    deleteAnimation.stop();
                    if (!deleteAnimation.running)
                        typingAnimation.restart();
                }
            }
        }
    }

    ColumnLayout {
        anchors.top: rec.bottom
        width: root.width
        height: root.height - rec.height
        anchors.topMargin: 20

        CustomTextField {
            Layout.preferredHeight: 40
            Layout.preferredWidth: root.width - 40
            Layout.alignment: Qt.AlignCenter

            focus: true
        }

        RoundCornersButton {
            id: btn

            Layout.preferredHeight: 50
            Layout.preferredWidth: root.width - 35
            Layout.alignment: Qt.AlignCenter

            onClicked: {
                root.loginClicked();
            }
        }

        RowLayout {
            Layout.maximumHeight: 40
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            CustomCheckbox {
                id: checkbox
                Layout.preferredHeight: 20
                Layout.preferredWidth: 135
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 20
            }

            DropdownMenu {
                id: timeMenu
                Layout.preferredHeight: 25
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignJustify
                visible: checkbox.checked
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        Item {
            Layout.maximumHeight: 1
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: "#D9D9D9"
        }

        ColumnLayout {
            id: footer
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            TextLink {
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter

                text: "What is discord id?"
                font.pixelSize: 16

                onClicked: {
                    root.idInfoCliked();
                }
            }

            TextLink {
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter

                text: "Don't have an account?"
                font.pixelSize: 16

                onClicked: {
                    root.noAccountClicked();
                }
            }

            Item {
                Layout.maximumHeight: footer.height / 4
                Layout.minimumHeight: footer.height / 4
                Layout.fillWidth: true
            }
        }
    }
}

