import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: root
    minimumWidth: 900
    minimumHeight: 527

    visible: true
    title: qsTr("Overwatch manager")
    color: "transparent"

    header: ToolBar {
        id: topbar
        width: root.width
        height: root.height * 0.1
        background: Rectangle {
            anchors.fill: parent
            color: "#900c0c0d"
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#99000000"

        FastBlur {
            anchors.fill: background
            source: background
            radius: 30
            cached: true
        }
    }

    StackLayout {
        width: root.width
        height: root.height - topbar.height

        ColumnLayout {
            Layout.minimumHeight: parent.height
            Layout.minimumWidth: parent.width
            Layout.alignment: Qt.AlignCenter

            Button {
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 200
                Layout.preferredHeight: 70

                background: Rectangle {
                    radius: 10
                    color: "transparent"
                    border.color: "grey"
                    border.width: 2

                    Text {
                        text: "New Event"
                        anchors.centerIn: parent
                        color: "white"
                        font.pointSize: 10
                    }
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter

            SplitView {
                Layout.fillHeight: true
                Layout.fillWidth: true

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width / 4
                    Layout.minimumWidth: parent.width * 0.1
                    Layout.maximumWidth: parent.width / 3
                }

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 2 / 3
                    Layout.minimumWidth: 20
                }
            }
        }
    }
}
