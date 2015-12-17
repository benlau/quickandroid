import QtQuick 2.0
import QuickAndroid 0.1

Item {

    MaterialShadow {
        asynchronous: true
        anchors.fill: parent
        depth: 1
    }

    Rectangle {
        color: "#cddc39" // Lime 500
        anchors.fill: parent
    }
}

