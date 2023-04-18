import QtQuick 2.15

Rectangle {
    id: root

    color: "#2C2C2C"
    border.color: "#3C3C3C"
    border.width: 1
    radius: 4

    TextInput {
        id: input
        anchors.centerIn: parent
        font.family: "Helvetica Neue"
        font.pixelSize: 16
        color: "#FFFFFF"
        cursorPosition: 0
        selectByMouse: true
        focus: true
        //TODO add placeholder functionality
        //TODO ad an input mask explanation:
        /*
            every discord name has char limit (obviously)
            also there is a hashtag symbol
            and fixed 4 numbers (discriminator)
        */
        //TODO this regexp is for email, needs to be rewritten
        validator: RegExpValidator { regExp: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/ }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.IBeamCursor
        onPressed: {
            input.forceActiveFocus();
        }
    }
}
