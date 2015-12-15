import QtQuick 2.2
import QtQuick.Window 2.2
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./theme"

Window {
    id: window;
    width: 480
    height: 640
    visible: true

    // Use a background similar to splash screen.
    color: "#FFFFFF"

    // Prevent screen flicker
    Loader {
        id: loader
        anchors.fill: parent
        asynchronous: true

        sourceComponent: PageStack {
            id: stack
            objectName: "PageStack";
            anchors.fill: parent
            initialPage: Components {
            }
        }
    }

    Component.onCompleted: {
        ThemeManager.currentTheme = AppTheme
    }
}
