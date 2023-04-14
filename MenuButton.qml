import QtQuick 2.15
import QtQuick.Controls 2.0

Button {
    id: root

    property alias backgroundObj: background
    property alias textObj: text

    QtObject {
        id: internal

        property color backgroundColor: "#2e2f30"
        property color clikedColor: "grey"
    }

    background: Rectangle {
        id: background
        radius: 10
        color: internal.backgroundColor
        border.color: internal.backgroundColor
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
        background.color = internal.clikedColor;
    }

    onReleased: {
        background.color = internal.backgroundColor;
    }

}
