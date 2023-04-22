import QtQuick 2.15
import QtQuick.Controls 2.0

StackView {
    id: root

    enum RegistrationScreen {
        Login = 0,
        IDInfo,
        Register
    }

    enum Pages {
        FirstWelcome = 0,
        Main
    }
}
