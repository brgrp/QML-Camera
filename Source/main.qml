import QtQuick 2.4
import QtQuick.Window 2.2
import QtMultimedia 5.4
import QtQml 2.2

Rectangle
{
    visible: true
    id: views
    anchors.fill : parent
    state: "PhotoCapture"

    //-> Statemachine
    states: [
            State {
                name: "PhotoCapture"
                StateChangeScript {
                    script: {
                        camera.captureMode = Camera.CaptureStillImage
                        camera.start()
                        console.log("PhotoCapture mode")
                    }
                }
            },
            State {
                name: "PhotoPreview"
                StateChangeScript {
                    script: {
                        console.log("PhotoPreview mode")
                        //Capture Image and set Path + Name
                        camera.imageCapture.captureToLocation("./Output/" + Qt.formatDateTime(new Date(), "yyyyMMdd.hh:mm:ss")+".jpg");
                        console.log("ImageName: "+ Qt.formatDateTime(new Date(), "yyyyMMdd.hh:mm:ss")+".jpg")
                        camera.stop()
                    }
                }
            }
        ]

    //->InputSource
    Camera {
    id: camera
    captureMode: Camera.CaptureStillImage
        imageCapture {
            onImageCaptured: {
                photoPreview.source = preview
                views.state = "PhotoPreview"
                console.log("PhotoPreview")
            }
        }
    }

    //-> Layout
    MainView {
        id: mainForm
        anchors.fill: parent
        visible: views.state == "PhotoCapture"

        MouseArea {

            id:mainForm_mouseArea_live
            hoverEnabled: false
            anchors.fill: parent
            onClicked: {
                console.log("Clicked")
                views.state="PhotoPreview"
            }
        }
    }

    PhotoPreview{
        id: photoPreview
        anchors.fill: parent
        onClosed: views.state = "PhotoCapture"
        visible: views.state == "PhotoPreview"
        focus: visible
    }


    LastImages {
    id:lastImages
    anchors.fill: parent
    visible: views.state == "LastImages"
    focus: false
    }



}
