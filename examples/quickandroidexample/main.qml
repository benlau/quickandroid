import QtQuick 2.2
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import "./theme"

Application {
    width: 480
    height: 640
    icon : "image://drawable/icon.png"
//    icon: Qt.resolvedUrl("./res/drawable-hdpi/icon.png")
    theme: AppTheme

    Component.onCompleted: {
        start(Qt.resolvedUrl("Components.qml"));
    }
}
