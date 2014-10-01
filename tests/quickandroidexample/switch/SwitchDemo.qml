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
        title: qsTr("Switch Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

    }

    Column {
        anchors.top: actionBar.bottom
        anchors.topMargin: 48 * A.dp
        anchors.horizontalCenter: parent.horizontalCenter

        Switch {
            id: switch1
            height: 48 * A.dp
            checked: true
            onCheckedChanged: {
                switch2.checked = !checked;
            }
        }

        Switch {
            id: switch2
            height: 48 * A.dp
            checked: false
            onCheckedChanged: {
                switch1.checked = !checked;
            }
        }
    }

}
