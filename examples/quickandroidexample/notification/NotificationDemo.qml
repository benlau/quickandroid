import QtQuick 2.2
import QtQuick.Window 2.1
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Page {

    actionBar: ActionBar {
        id : actionBar
        title: "Notification"
        z: 10
        upEnabled: true
        onActionButtonClicked: back();
    }

    Text {
        id: label
        text : "Press to send notification"
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        type: Constants.largeText
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            SystemDispatcher.dispatch("Notifier.notify",{
                title: "Quick Android Example",
                message: "Hello!"
            });
        }
    }

}
