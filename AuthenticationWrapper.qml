import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.1

Window {
    id: root

    property string fontFamily: "Helvetica Neue"

    minimumWidth: Screen.width * 0.15
    minimumHeight: Screen.height * 0.4
    maximumWidth: Screen.width * 0.15
    maximumHeight: Screen.height * 0.4
    visible: true
    //flags: Qt.FramelessWindowHint | Qt.Window

    Rectangle {
        id: rec

        property int currentIndex: 0
        property var words: ["Welcome!", "こにちは!", "Salut!", "Bonjour!", "Välkommen!"]
        property int wordLength: 0

        width: root.width
        height: root.height * 0.4

        RowLayout {
            spacing: 0
            anchors.centerIn: parent

            Text {
                id: text
                text: ""
                font.family: root.fontFamily
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

        MouseArea {
            id: mouseArea

            property point pos

            anchors.fill: parent

            onPressed: {
                mouseArea.pos = Qt.point(mouse.x, mouse.y);
            }

            onPositionChanged: {
                var diff = Qt.point(mouse.x - mouseArea.pos.x, mouse.y - mouseArea.pos.y);
                root.x += diff.x;
                root.y += diff.y;
            }
        }
    }

    ColumnLayout {
        anchors.top: rec.bottom
        width: root.width
        height: root.height - rec.height
        anchors.topMargin: 20

        TextField {
            Layout.preferredHeight: 40
            Layout.preferredWidth: root.width - 40
            Layout.alignment: Qt.AlignCenter
        }

        Rectangle {
            id: btn
            Layout.preferredHeight: 50
            Layout.preferredWidth: root.width - 35
            Layout.alignment: Qt.AlignCenter
            color: "#0078D7"
            border.color: "#0078D7"
            border.width: 1
            radius: 4

            Text {
                id: label
                text: qsTr("Log In")
                font.family: "Helvetica Neue"
                font.pixelSize: 16
                color: "#FFFFFF"
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onPressed: {
                    btn.color = "#005A9E";
                    label.color = "#E5E5E5";
                }
                onReleased: {
                    btn.color = "#0078D7";
                    label.color = "#FFFFFF";
                }
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
                    //TODO
                }
            }

            TextLink {
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter

                text: "Don't have an account?"
                font.pixelSize: 16

                onClicked: {
                    //TODO
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
