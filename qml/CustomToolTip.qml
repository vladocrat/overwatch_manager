import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: root

    property Item contentItem
    property Popup popup

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        property point pos

        onPositionChanged: {
            ma.pos = Qt.point(mouse.x, mouse.y);
        }

        onEntered: {
            root.popup.x = ma.pos.x;
            root.popup.y = ma.pos.y;
            root.popup.open();
        }

        onExited: {
            root.popup.close();
        }
    }

    onContentItemChanged: {
        root.contentItem.enabled
    }
}

