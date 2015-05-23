import QtQuick 2.4
import QtQuick.Window 2.2
import QtMultimedia 5.4

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
                        }
                    }
                },
                State {
                    name: "PhotoPreview"
                },
                State {
                    name: "VideoPreview"
                    StateChangeScript {
                        script: {
                            camera.stop()
                        }
                    }
                }
            ]
        //-> Layout
        MainForm {
            id: mainForm
            anchors.fill: parent


        }


        PhotoPreview{
            id: photoPreview
            anchors.fill: parent
            onClosed: views.state = "PhotoCapture"
            visible: views.state == "PhotoPreview"
            focus: visible
        }

        //->Functions / Inputsource
        Camera {
            id: camera
            captureMode: Camera.CaptureStillImage
            imageCapture {
                onImageCaptured: {
                    PhotoPreview.source = preview
                    views.state = "PhotoPreview"
                }
            }
        }

    }

