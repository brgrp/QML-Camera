import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id: mainForm
    width: 800
    height: 600

    signal closed
    signal shoot


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
                visible: views.state === "PhotoCapture"
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
        }



}

