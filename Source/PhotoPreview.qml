import QtQuick 2.0
import QtMultimedia 5.4


Item {
    property alias source : preview.source
    signal closed

    Image {
        id: preview
        anchors.fill : parent
        fillMode: Image.PreserveAspectFit
        smooth: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.closed();
        }
    }
}
