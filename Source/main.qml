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
                        console.log("absImagePath: "+ absImagePath)

                        camera.imageCapture.captureToLocation(absImagePath + Qt.formatDateTime(new Date(), "yyyyMMdd.hh:mm:ss")+".jpg")
                        //-> This one fails on windows..
                        //camera.imageCapture.captureToLocation(directory + "/"+ Qt.formatDateTime(new Date(), "yyyyMMdd.hh:mm:ss")+".jpg");

                        //-> Set Meta Description
                        camera.imageCapture.setMetadata("Description", "BigParty")


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
    CameraSelector {
        id: selector
        cameraObject: camera
    }

    ListModel {
        id: imagePaths
    }

    Camera {
    id: camera
        captureMode: Camera.CaptureStillImage

            imageCapture {
            onImageCaptured: {
                photoPreview.source = preview
                console.log("Captured Image Path: "+ camera.imageCapture.capturedImagePath.toString())

                views.state = "PhotoPreview"
                console.log("PhotoPreview" )

                }
            onImageSaved: {
                imagePaths.insert(0,{"imagepath": path})
                console.log("onImageSaved path: ",path)
            }
        }
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

    ListView {
        anchors.fill: parent

        model: QtMultimedia.availableCameras
        delegate: Text {
            text: modelData.displayName

            MouseArea {
                anchors.fill: parent
                onClicked: camera.deviceId = modelData.deviceId
            }
        }
    }

}
