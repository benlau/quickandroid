import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Page {
    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Dialog Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

    }

    Text {
        id: label
        text : "Press to launch dialog"
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        type: Constants.largeText
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            dialog.open();
        }
    }

    Dialog {
        id: dialog
        anchors.centerIn: parent
        title: "Dialog"
        Text {
            text: "Demo"
        }
        z: 20

        rejectButtonText: "OK"
    }
}
