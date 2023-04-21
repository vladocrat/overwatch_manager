import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.1

Window {
    id: root

    property string fontFamily: "Helvetica Neue"

    minimumWidth: Screen.width * 0.15
    minimumHeight: Screen.height * 0.4
    maximumWidth: Screen.width * 0.15
    maximumHeight: Screen.height * 0.4
    visible: true
    //flags: Qt.FramelessWindowHint | Qt.Window

    LoginScreen {
        anchors.fill: parent
    }
}
