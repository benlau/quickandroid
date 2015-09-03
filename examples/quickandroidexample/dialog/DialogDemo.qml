import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import "../theme"

Activity {
    actionBar: AppActionBar {
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
        color : Style.theme.black87
        font.pixelSize: Style.theme.largeText.textSize * A.dp
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            dialog.open();
        }
    }

    AlertDialog {
        id: dialog
        anchors.centerIn: parent
        message: "What do you think about QuickAndroid?"
        z: 20
    }
}
