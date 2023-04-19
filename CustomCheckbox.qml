import QtQuick 2.15
import QtQuick.Controls 2.0

CheckBox {
    id: root

    font.family: "Helvetica Neue"
    text: "Remember me"
    font.pixelSize: 14
    checked: false

    background: Rectangle {
        id: background
        width: 25
        height: 25
        color: "white"
        border.color: "#3C3C3C"
        border.width: 1
        radius: 4
    }

    indicator: Rectangle {
        width: 10
        height: 10
        anchors.centerIn: background
        color: "#2C2C2C"
        border.color: "#3C3C3C"
        border.width: 1
        radius: 4
        visible: root.checked
    }

    contentItem: Text {
        text: root.text
        font: root.font
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignJustify
    }
}

