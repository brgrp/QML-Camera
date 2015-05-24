import QtQuick 2.0

Rectangle
{
    signal updateList
    signal startPlayBack

    onUpdateList: {
        lastImages_ListView.positionViewAtBeginning();
        console.log("lastImages_ListView.positionViewAtEnd();")
    }

    onStartPlayBack: {
        startPlayBack()
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
        delegate: Image { source: "file://"+path; asynchronous: true; fillMode: Image.PreserveAspectFit; height: parent.height; anchors.topMargin: 10 }
        Rectangle {
            anchors.fill: parent
            color: "grey"
            opacity: 0.1
            border.color: Qt.lighter(color)
        }
    }
}

