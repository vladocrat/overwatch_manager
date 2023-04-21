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

        LoginScreen {
            Layout.fillHeight: true
            Layout.fillWidth: true

            onLoginClicked: {
                //TODO implement
            }

            idInfoCliked: {
                manager.currentIndex = PageManager.RegistrationScreen.IDInfo;
            }

            onNoAccountClicked: {
                manager.currentIndex = PageManager.RegistrationScreen.Register;
            }
        }

        IDInfoScreen {
            onBackClicked: {
                manager.currentIndex = PageManager.Registration.Login;
            }
        }

        RegistrationScreen {
            onBackClicked: {
                manager.currentIndex = PageManager.Registration.Login;
            }
        }
    }
}
