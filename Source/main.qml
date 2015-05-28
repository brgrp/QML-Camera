import QtQuick 2.4
import QtQuick.Window 2.2
import QtMultimedia 5.4
import QtQml 2.2
import cameraSelector 1.0

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
                        //SetCaptureDevice

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
                        console.log("Captured Image Path: "+ camera.imageCapture.capturedImagePath.toString())
                    }
                }
            },
        State {
            name: "PhotoReview"
            StateChangeScript {
                script: {
                    console.log("PhotoReview mode")
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

    CameraSelector {
        id: selector
        cameraObject: camera
    }

    ListModel {
        id: imagePaths
    }


   //-> Layout
    MainView {
        id: mainView
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.fill: parent
        visible: views.state == "PhotoCapture"



        MouseArea {
            id:mainView_mouseArea_live
            visible: parent.visible
            hoverEnabled: false
            height: parent.height*0.75
            width: parent.width
            onClicked: {
                console.log("Clicked: "+ absImagePath)
                views.state="PhotoPreview"
            }
        }



    }

    Rectangle{
        color:"red"
        width: 100
        height: 100
        y:100

        MouseArea
        {
            anchors.fill: parent
            onClicked: {
                selector.selectedCameraDevice= 1;
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
        visible: views.state == "PhotoPreview" || views.state == "PhotoReview"
        focus: visible
    }

}
