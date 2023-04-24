import QtQuick 2.15
import ApplicationSettings 1.0

Item {
    id: root

    signal clicked();

    property alias font: linkText.font
    property string text: "text"
    property color defaultColor: "#0078FF"
    property color highlightColor: "#00BFFF"

    Text {
        id: linkText
        text: root.text
        font.underline: true
        font.family: AppSettings.fontFamily
        color: root.defaultColor
        anchors.centerIn: parent

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onEntered: {
                linkText.color = root.highlightColor;
            }

            onExited: {
                linkText.color = root.defaultColor;
            }

            onClicked: {
                root.clicked();
            }
        }
    }
}
