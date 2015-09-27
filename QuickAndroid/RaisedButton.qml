import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Button {
    id: button

    property RaisedButtonStyle aStyle: ThemeManager.currentTheme.raisedButton

    property string color: aStyle.color
    property int depth: aStyle.depth

    background: Rectangle {
        property bool pressed: false
        color: button.color

        MaterialShadow {
            asynchronous: true
            anchors.fill: parent
            z: -1
            depth: button.depth
        }

        Rectangle {
            anchors.fill: parent
            color:  pressed ? "#1A000000" : Constants.transparent
        }
    }
}

