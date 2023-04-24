import QtQuick 2.0
import QtQuick.Controls 2.0
import ApplicationSettings 1.0

Rectangle {
    id: root

    signal clicked();

    property alias colors: colors

    color: colors.backgroundDefault
    border.width: 1
    border.color: colors.borderDefault

    QtObject {
        id: colors

        property color backgroundDefault: "transparent"
        property color backgroundPressed: "#E3F1F6"
        property color borderDefault: "white"
        property color textDefault: "#9FA9CF"
        property color textPressed: "#6F8CF8"
    }

    Label {
        id: text

        anchors.centerIn: parent
        text: "<--"
        font.pixelSize: 20
        font.family: AppSettings.fontFamily
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true

        onPressed: {
            root.color = colors.backgroundPressed;
            text.color = colors.textPressed;
        }

        onReleased: {
            root.color = colors.backgroundDefault;
            text.color = colors.textDefault;
        }

        onClicked: {
            root.clicked();
        }
    }
}
