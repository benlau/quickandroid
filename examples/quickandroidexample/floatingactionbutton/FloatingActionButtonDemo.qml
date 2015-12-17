import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Page {
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
                    backgroundColor: "red"
                    iconSource: A.drawable("ic_done_black_24dp",Constants.white87);
                    depth: modelData
                    anchors.verticalCenter: parent.verticalCenter
                }

                rightIcon: FloatingActionButton {
                    backgroundColor: "blue"
                    iconSource: A.drawable("ic_done_black_24dp",Constants.white87);
                    depth: modelData
                    anchors.verticalCenter: parent.verticalCenter
                    size: Constants.small
                }
            }
        }


    }


}
