import QtQuick 2.4
import QtQuick.Window 2.2
import QtMultimedia 5.0

Rectangle {
    id: mainForm
    width: 800
    height: 600

    MouseArea {
        id:mainForm_mouseArea_live
        hoverEnabled: false
        anchors.fill: live

        onClicked: console.log("Clicked")
    }

    Grid {
            id: live
            y: 0
            height: 478
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: -400
            anchors.left: parent.left
            anchors.leftMargin: 0

            VideoOutput {
                id: viewfinder
                visible: views.state === "PhotoCapture" || views.state === "VideoCapture"
                x: 0
                y: 0
                width: parent.width
                height: parent.height
                source: camera
            }
        }

        GridView {
            id: view
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: live.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            cellHeight: 70

            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }

                ListElement {
                    name: "Green"
                    colorCode: "green"
                }
            }
            cellWidth: 70
            delegate: Item {
                x: 5
                height: 50
                Column {
                    spacing: 5
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        x: 5
                        text: name
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }

}
