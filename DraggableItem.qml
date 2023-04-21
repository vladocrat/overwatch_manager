import QtQuick 2.15

Item {
    id: root

    signal positionChanged();

    required property QtObject target

    MouseArea {
        id: mouseArea

        property point pos

        anchors.fill: parent

        onPressed: {
            mouseArea.pos = Qt.point(mouse.x, mouse.y);
        }

        onPositionChanged: {
            var diff = Qt.point(mouse.x - mouseArea.pos.x, mouse.y - mouseArea.pos.y);
            root.target.x += diff.x;
            root.target.y += diff.y;
            root.positionChanged();
        }
    }
}
