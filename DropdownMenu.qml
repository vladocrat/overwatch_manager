import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

ComboBox {
    id: root
    model: ["Week", "Month", "Never"]
    currentIndex: 1

    background:  Rectangle {
        anchors.fill: parent
        color: "#e0dede"
        radius: 5
    }

    delegate: ItemDelegate {
        id: delegate
        width: parent.width
        height: 30

        contentItem: Text {
            text: modelData
            font.pixelSize: 16
            color: "#FFFFFF"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#36393F"
        }
    }

    onCurrentIndexChanged: {
        //dropdown.visible = false;
    }
}

