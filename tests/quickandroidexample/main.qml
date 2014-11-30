import QtQuick 2.2
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Application {
    width: 480
    height: 640
    icon : Qt.resolvedUrl("drawable-hdpi/icon.png")

    theme : Theme {
        actionBar.background : "#cddc39" // Lime 500
    }

    Component.onCompleted: {
        start(Qt.resolvedUrl("Components.qml"));
    }
}
