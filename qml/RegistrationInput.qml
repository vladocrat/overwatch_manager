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

    QtObject {
        id: internal

        function digit(event, from, to) {
            from.setDigit(event);
            to.forceActiveFocus();
        }

        function backspace(from, to) {
            from.digit = 0;
            to.forceActiveFocus();
        }
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
                    internal.digit(event, digit1Rect, digit2Rect);
                } else if (event.key === Qt.Key_Backspace) {
                    internal.backspace(digit1Rect, digit1Rect);
                }
            }
        }

        SingleDigitInput {
            id: digit2Rect

            width: 40
            height: 40

            Keys.onPressed: {
                if (digit2Rect.isDigit(event)) {
                    internal.digit(event, digit2Rect, digit3Rect);
                } else if (event.key === Qt.Key_Backspace) {
                    internal.backspace(digit2Rect, digit1Rect);
                }
            }
        }

        SingleDigitInput {
            id: digit3Rect

            width: 40
            height: 40

            Keys.onPressed: {
                if (digit3Rect.isDigit(event)) {
                    internal.digit(event, digit3Rect, digit4Rect);
                } else if (event.key === Qt.Key_Backspace) {
                    internal.backspace(digit3Rect, digit2Rect);
                }
            }
        }

        SingleDigitInput {
            id: digit4Rect

            width: 40
            height: 40

            Keys.onPressed: {
                if (digit4Rect.isDigit(event)) {
                    internal.digit(event, digit4Rect, digit4Rect);
                } else if (event.key === Qt.Key_Backspace) {
                    internal.backspace(digit4Rect, digit3Rect);
                }
            }
        }
    }
}

