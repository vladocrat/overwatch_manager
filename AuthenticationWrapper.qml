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

        TextField {
            Layout.preferredHeight: 40
            Layout.preferredWidth: root.width - 40
            Layout.alignment: Qt.AlignCenter

           // font.family: "Helvetica Neue"
            //font.pixelSize: 16
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

        Rectangle {
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            Layout.alignment: Qt.AlignCenter
            color: "#2C2C2C"
            border.color: "#3C3C3C"
            border.width: 1
            radius: 4

            CheckBox {
                id: checkbox
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Helvetica Neue"
                text: qsTr("Remember me")
                font.pixelSize: 14
                checked: false
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onPressed: {
                    checkbox.forceActiveFocus();
                    checkbox.checked = !checkbox.checked;
                }
            }
        }
    }
}
