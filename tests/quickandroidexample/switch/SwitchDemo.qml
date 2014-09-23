import QtQuick 2.0
import QuickAndroid 0.1

Activity {
    MaterialShadow {
        asynchronous: true
        anchors.fill: actionBar
        depth: 1
    }

    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Dialog Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

    }

    Column {
        anchors.top: actionBar.bottom
        anchors.topMargin: 48 * A.dp
        anchors.horizontalCenter: parent.horizontalCenter

        Switch {
            height: 48 * A.dp
            checked: true
        }

        Switch {
            height: 48 * A.dp
            checked: false
        }
    }

}
