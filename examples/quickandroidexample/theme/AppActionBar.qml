import QtQuick 2.0
import QuickAndroid 0.1

// Custom Action Bar for this application
ActionBar {

    MaterialShadow {
        asynchronous: true
        anchors.fill: actionBar
        depth: 1
        z: -1
    }
}

