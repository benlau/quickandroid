import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Activity {
    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Floating Action Button")
        showTitle: true

        onActionButtonClicked: back();

        MaterialShadow {
            asynchronous: true
            anchors.fill: actionBar
            depth: 1
            z: -1
        }
    }

    FloatingActionButton {
        color: "red"
        iconSource: "image://drawable/ic_done_black_24dp?tintColor=" + escape(Style.theme.white87)
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 24 * A.dp
        anchors.bottomMargin: 24 * A.dp
    }

}
