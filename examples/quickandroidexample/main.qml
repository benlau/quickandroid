import QtQuick 2.2
import QtQuick.Window 2.2
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./theme"

Window {
    width: 480
    height: 640
    visible: true
    color: "#000000"

    PageStack {
        objectName: "PageStack";
        anchors.fill: parent
        initialPage: Components {
        }
    }

    Component.onCompleted: {
        ThemeManager.currentTheme = AppTheme;
    }
}
