import QtQuick 2.0

Rectangle {
    width: 200
    height: 200

    Rectangle {
        width: 50
        height: 50
        color: "red"
        transform: Rotation { origin.x: width / 2; origin.y: height / 2; angle: 180 }
    }
}
