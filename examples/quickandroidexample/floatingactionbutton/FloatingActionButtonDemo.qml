import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Activity {
    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Floating Action Button")
        showTitle: true

        onActionButtonClicked: back();
    }

    Column {
        anchors.fill: parent

        Repeater {
            model: [1,2,3,4,5]
            delegate: ListItem {
                height: 72 * A.dp
                title: "   Depth = " + modelData
                icon: FloatingActionButton {
                    color: "red"
                    iconSource: "image://drawable/ic_done_black_24dp?tintColor=" + escape(Style.theme.white87)
                    depth: modelData
                    anchors.verticalCenter: parent.verticalCenter
                }

                rightIcon: FloatingActionButton {
                    color: "blue"
                    iconSource: "image://drawable/ic_done_black_24dp?tintColor=" + escape(Style.theme.white87)
                    depth: modelData
                    anchors.verticalCenter: parent.verticalCenter
                    size: Constants.small
                }
            }
        }


    }


}
