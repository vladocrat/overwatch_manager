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
            Layout.fillHeight: true
            Layout.fillWidth: true

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
            Layout.fillHeight: true
            Layout.fillWidth: true

            onBackClicked: {
                manager.currentIndex = PageManager.Registration.Login;
            }
        }

        RegistrationScreen {
            Layout.fillHeight: true
            Layout.fillWidth: true

            onBackClicked: {
                manager.currentIndex = PageManager.Registration.Login;
            }
        }
    }
}
