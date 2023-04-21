import QtQuick 2.15
import QtQuick.Layouts 1.12

StackLayout {
    id: root

    enum RegistrataionScreen {
        Login = 0,
        IDInfo,
        Register
    }

    enum Pages {
        FirstWelcome = 0,
        Main
    }
}
