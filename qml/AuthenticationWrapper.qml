import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.1

Window {
    id: root

    minimumWidth: Screen.width * 0.15
    minimumHeight: Screen.height * 0.4
    maximumWidth: Screen.width * 0.15
    maximumHeight: Screen.height * 0.4

    visible: true

    QtObject {
        id: internal

        function move(relative) {
            root.x += relative.x
            root.y += relative.y
        }
    }

    PageManager {
        id: manager

        anchors.fill: parent

        initialItem: loginScreen
    }

    LoginScreen {
        id: loginScreen

        visible: false

        onMoved: {
            internal.move(loginScreen);
        }

        onLoginClicked: {
            //TODO implement
        }

        onIdInfoCliked: {
            manager.push(infoScreen);
        }

        onNoAccountClicked: {
            manager.push(registrationScreen)
        }
    }

    IDInfoScreen {
        id: infoScreen

        visible: false
        target: root

        onBackClicked: {
            manager.pop();
        }
    }

    RegistrationScreen {
        id: registrationScreen

        visible: false

        onMoved: {
            internal.move(registrationScreen);
        }

        onBackClicked: {
            manager.pop();
        }
    }
}
