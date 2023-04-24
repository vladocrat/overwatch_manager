import QtQuick 2.0
import QtQuick.Layouts 1.15

Rectangle {
    id: root

    property int digit
    property alias text: digitText.text

    function setDigit(event) {
        root.digit = (event.key - Qt.Key_0);
    }

    color: "#f2f2f2"
    border.color: "#d9d9d9"
    border.width: 1
    radius: 5

    RowLayout {
        anchors.centerIn: parent
        spacing: 0

        Text {
            id: digitText

            text: root.digit.toString();
            font.pixelSize: 20
        }

        Rectangle {
            id: cursor

            width: 2
            height: digitText.font.pixelSize
            color: "red"
            visible: root.focus

            NumberAnimation on opacity {
                from: 1
                to: 0
                duration: 700
                loops: Animation.Infinite
                running: true
            }
        }
    }
}

