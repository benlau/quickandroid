import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {

    property bool active: false;

    color: Constants.black100

    opacity: active ? 0.3 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
}

