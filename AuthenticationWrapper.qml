import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root
    minimumWidth: Screen.width * 0.15
    minimumHeight: Screen.height * 0.4
    maximumWidth: Screen.width * 0.15
    maximumHeight: Screen.height * 0.4
    visible: true

    AuthenticationPopup {
        width: root.width
        height: root.height
    }
}
