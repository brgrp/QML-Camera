import QtQuick 2.0
import QtMultimedia 5.4

Rectangle {
    id: mainForm
    anchors.fill: parent
    signal closed
    signal update
    signal noaction

    onNoaction: {
        lastImages.startPlayBack()
    }

    onUpdate: {
        lastImages.updateList()
    }

    Grid {
            id: live
            height: parent.height*0.75
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top

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

    LastImages {
        id:lastImages
        height: mainForm.height-live.height
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        visible: views.state === "PhotoCapture"
    }



}

