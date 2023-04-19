import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.1

Window {
    id: root
    minimumWidth: Screen.width * 0.15
    minimumHeight: Screen.height * 0.4
    maximumWidth: Screen.width * 0.15
    maximumHeight: Screen.height * 0.4
    visible: true
    //flags: Qt.FramelessWindowHint | Qt.Window

    Rectangle {
        id: rec

        width: root.width
        height: root.height * 0.4
        color: "red"

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
