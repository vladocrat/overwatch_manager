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

    PageManager {
        id: manager

        anchors.fill: parent

        LoginScreen {
            id: loginScreen

            Layout.fillHeight: true
            Layout.fillWidth: true

            onMoved: {
                root.x += loginScreen.x
                root.y += loginScreen.y
            }

            onLoginClicked: {
                //TODO implement
            }

            onIdInfoCliked: {
                manager.currentIndex = PageManager.RegistrationScreen.IDInfo;
            }

            onNoAccountClicked: {
                manager.currentIndex = PageManager.RegistrationScreen.Register;
            }
        }

        IDInfoScreen {
            id: infoScren

            Layout.fillHeight: true
            Layout.fillWidth: true

            target: root

            onBackClicked: {
                manager.currentIndex = PageManager.RegistrationScreen.Login;
            }
        }

        RegistrationScreen {
            Layout.fillHeight: true
            Layout.fillWidth: true

            onBackClicked: {
                manager.currentIndex = PageManager.RegistrationScreen.Login;
            }
        }
    }
}
