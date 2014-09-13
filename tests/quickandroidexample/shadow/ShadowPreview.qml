import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {
    width: 100
    height: 100
    color : "#ffffff"

    MaterialShadow {
        anchors.fill: parent
        z : -10
        depth : 5
        asynchronous: true
    }
}
