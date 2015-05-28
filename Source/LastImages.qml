import QtQuick 2.0
import QtMultimedia 5.4

Item
{
    id:last_images
    signal updateList

    onUpdateList: {
        lastImages_ListView.positionViewAtBeginning();
        console.log("lastImages_ListView.positionViewAtBeginning();")
    }

    ListView {
        id:lastImages_ListView
        anchors.fill: parent
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        orientation: ListView.Horizontal
        rightMargin: 10
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }

        model: imagePaths
        delegate: Image {
            source: "file://"+ imagepath
            asynchronous: true;
            fillMode: Image.PreserveAspectFit;
            height: parent.height;
            anchors.topMargin: 10

            MouseArea {
                     id:mainView_mouseArea_Lastimage
                     hoverEnabled: false
                     anchors.fill: parent

                     onClicked: {
                         lastImages_ListView.currentIndex = index
                         last_images.forceActiveFocus()
                         console.log("CurrentIndex: " + lastImages_ListView.currentIndex +  "Size: ",lastImages_ListView.count)
                         console.log("CurrentPath: " + imagePaths.get(lastImages_ListView.currentIndex ).imagepath)
                         photoPreview.source = "file://"+ imagePaths.get(lastImages_ListView.currentIndex ).imagepath
                         views.state="PhotoReview"
                     }
                 }
        }

        Rectangle {
            anchors.fill: parent
            color: "grey"
            opacity: 0.1
            border.color: Qt.lighter(color)
        }
    }





}

