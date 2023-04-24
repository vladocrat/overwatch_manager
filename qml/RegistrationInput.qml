import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

Item {
    id: root

    width: 200
    height: 50

    onFocusChanged: {
        if (root.focus)
            digit1Rect.forceActiveFocus();
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: 10

        SingleDigitInput {
            id: digit1Rect

            width: 40
            height: 40

            Keys.onPressed: {
               if (digit1Rect.isDigit(event)) {
                   digit1Rect.digit = (event.key - Qt.Key_0);
                   digit2Rect.forceActiveFocus();
               }
            }
        }

        SingleDigitInput {
            id: digit2Rect

            width: 40
            height: 40

            Keys.onPressed: {
                if (digit2Rect.isDigit(event)) {
                    digit2Rect.digit = (event.key - Qt.Key_0);
                    digit3Rect.forceActiveFocus();
                }
            }
        }

        SingleDigitInput {
            id: digit3Rect

            width: 40
            height: 40

            Keys.onPressed: {
                if (digit3Rect.isDigit(event)) {
                    digit3Rect.digit = (event.key - Qt.Key_0);
                    digit4Rect.forceActiveFocus();
                }
            }
        }

        SingleDigitInput {
            id: digit4Rect

            width: 40
            height: 40

            Keys.onPressed: {
                if (digit4Rect.isDigit(event)) {
                    digit4Rect.digit = (event.key - Qt.Key_0);
                }
            }
        }
    }
}

