import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {
    width: 120 * A.dp
    height: 48 * A.dp

    Switch {
        anchors.centerIn: parent
        checked: true
    }
}
