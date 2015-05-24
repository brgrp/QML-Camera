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
                        camera.imageCapture.captureToLocation(absImagePath + "/"+ Qt.formatDateTime(new Date(), "yyyyMMdd.hh:mm:ss")+".jpg");
                        console.log("Captured Image Path: "+camera.imageCapture.capturedImagePath.toString())
                    }
                }
            }
        ]

    //->InputSource // Members
    Camera {
    id: camera
    captureMode: Camera.CaptureStillImage
        imageCapture {
            onImageCaptured: {
                photoPreview.source = preview
                views.state = "PhotoPreview"
                console.log("PhotoPreview")
            }
            onImageSaved: {
                imagePaths.insert(0,{"path": path})
            }
        }
    }

    ListModel {
        id: imagePaths
    }


    //-> Layout
    MainView {
        id: mainView
        anchors.fill: parent
        visible: views.state == "PhotoCapture"

        MouseArea {
            id:mainView_mouseArea_live
            hoverEnabled: false
            height: parent.height*0.75
            width: parent.width
            onClicked: {
                console.log("Clicked: "+ absImagePath)
                views.state="PhotoPreview"
            }
        }
    }


    PhotoPreview{
        id: photoPreview
        anchors.fill: parent
        onClosed: {

            views.state = "PhotoCapture"
            mainView.update()
        }
        visible: views.state == "PhotoPreview"
        focus: visible
    }

}
