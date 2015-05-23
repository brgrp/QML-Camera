import QtQuick 2.0

Rectangle {
    width: 100
    height: 100

    Rectangle {
        id: square
        width: 48
        height: 48
        color: "#ea7025"
        border.color: Qt.lighter(color)
    }

//    Image {
//        id: preview
//        anchors.fill : parent
//        fillMode: Image.PreserveAspectFit
//        smooth: true
//    }
}

