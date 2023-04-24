import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15
import Clipboard 1.0

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

        function isDigit(event) {
            return (event.key >= Qt.Key_0 && event.key <= Qt.Key_9);
        }

        //meaning: ctrl + v was pressed
        function pasted(event) {
            return (event.modifiers & Qt.ControlModifier && event.key === Qt.Key_V);
        }

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

            Clipboard {
                id: clipboard
            }

            Keys.onPressed: {
                if (internal.isDigit(event)) {
                    internal.digit(event, digit1Rect, digit2Rect);
                } else if (event.key === Qt.Key_Backspace) {
                    internal.backspace(digit1Rect, digit1Rect);
                } else if (internal.pasted) {
                    if (clipboard.text.length > 4) {
                        console.warn("clipboard is bigger than allowed: " + clipboard.text.length);
                        return;
                    }

                    if (clipboard.text.length === 0) {
                        console.warn("clipboard is empty");
                        return;
                    }

                    if (isNaN(parseInt(clipboard.text))) {
                        console.log("no numbers in clipboard");
                        return;
                    }

                    var arr = clipboard.text.split("");
                    digit1Rect.digit = parseInt(arr[0]);
                    digit2Rect.digit = parseInt(arr[1]);
                    digit3Rect.digit = parseInt(arr[2]);
                    digit4Rect.digit = parseInt(arr[3]);
                    digit4Rect.forceActiveFocus();
                }
            }
        }

        SingleDigitInput {
            id: digit2Rect

            width: 40
            height: 40

            Keys.onPressed: {
                if (internal.isDigit(event)) {
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
                if (internal.isDigit(event)) {
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
                if (internal.isDigit(event)) {
                    internal.digit(event, digit4Rect, digit4Rect);
                } else if (event.key === Qt.Key_Backspace) {
                    internal.backspace(digit4Rect, digit3Rect);
                }
            }
        }
    }
}

