import QtQuick 2.15
import QtQuick.Controls 2.0

Button {
    id: root

    property alias backgroundObj: background
    property alias textObj: text
    property color backgroundColor: "#2e2f30"
    property color clikedColor: "grey"

    background: Rectangle {
        id: background
        radius: 10
        color: root.backgroundColor
        border.color: root.backgroundColor
        border.width: 2

        Text {
            id: text
            text: "TEXT"
            anchors.centerIn: parent
            color: "white"
            font.pointSize: 20
            font.family: "Nunito"
        }
    }

    onPressed: {
        background.color = root.clikedColor;
    }

    onReleased: {
        background.color = root.backgroundColor;
    }

}
