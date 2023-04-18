import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12

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
        width: root.width
        height: root.height - rec.height

        TextInput {
            Layout.preferredHeight: 20
            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignCenter
        }
    }
}
