import QtQuick 2.15
import QtQuick.Controls 2.0

Rectangle {
    id: root

    property alias placeholder: placeholderObj
    property alias textInput: input
    property alias font: internal
    property string placeholderText: textHelper.text
    property color textInputColor: "#FFFFFF"

    color:  "#2C2C2C"
    border.color: "#3C3C3C"
    border.width: 1
    radius: 4

    QtObject {
        id: internal

        property int pixelSize: 16
        property string family: "Helvetica Neue"
    }

    Label {
        id: placeholderObj

        QtObject {
            id: textHelper

            property string text: "Your discord id"
        }

        color: root.textInputColor
        visible: input.text.length === 0;
        anchors.centerIn: input
        text: textHelper.text
        font.family: internal.family
        font.pixelSize: internal.pixelSize
    }

    TextInput {
        id: input
        anchors.centerIn: parent
        font.family: internal.family
        font.pixelSize: internal.pixelSize
        color: root.textInputColor
        cursorPosition: 20
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
