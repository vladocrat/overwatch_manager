import QtQuick 2.15

Rectangle {
    id: root

    signal clicked();

    property alias label: label
    property alias mouseArea: mouseArea
    property alias colors: colors

    color: colors.backgroundDefualt
    border.color: colors.backgroundBorder
    border.width: 1
    radius: 4

    QtObject {
        id: colors

        property color textDefault: "#FFFFFF"
        property color textPressed: "#E5E5E5"
        property color backgroundDefualt: "#0078D7"
        property color backgroundPressed: "#005A9E"
        property color backgroundBorder: "#0078D7"
    }

    Text {
        id: label

        anchors.centerIn: parent

        text: qsTr("Log In")
        font.family: "Helvetica Neue"
        font.pixelSize: 16
        color: colors.textDefault
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onPressed: {
            root.color = colors.backgroundPressed;
            label.color = colors.textPressed;
        }

        onReleased: {
            root.color = colors.backgroundDefualt;
            label.color = colors.textDefault;
        }

        onClicked: {
            root.clicked();
        }
    }
}
