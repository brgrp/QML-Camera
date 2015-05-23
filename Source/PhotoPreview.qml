import QtQuick 2.0
import QtMultimedia 5.4


Item {
    property alias image : preview.source
    signal closed

    Image {
        id: preview
        source: image
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
