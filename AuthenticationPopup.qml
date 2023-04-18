import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Window 2.2

Popup {
    id: root
    x: Math.round((Screen.width - root.width) / 2)
    y: Math.round((Screen.height - root.height) / 2)
    modal: true;
}

