import QtQuick 2.0
import QtQuick.Controls 2.15

ToolTip {
    id: root

    background: Rectangle {
        anchors.fill: parent
        border.width: 2
        color: "#2C2C2C"
    }

    enter: Transition {
        NumberAnimation {
            id: fadeIn

            target: root
            property: "opacity"
            from: 0
            to: 1
            duration: 1000
        }
    }

    exit: Transition {
        NumberAnimation {
            id: fadeOut

            target: root
            property: "opacity"
            from: 1
            to: 0
            duration: 1000

            onRunningChanged: {
                if (!fadeOut.running) {
                    fadeOut.destroy();
                }
            }
        }
    }
}
