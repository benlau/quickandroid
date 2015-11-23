import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Page {

    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Shadow Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10
    }

    ListView {
        anchors.top : parent.top
        anchors.topMargin: 8 * A.dp
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        model : 5
        spacing : 16 * A.dp
        delegate : Item {
            width: parent.width
            height: childrenRect.height

            Column {
                width: parent.width

                Paper {
                    id: paper
                    depth: modelData + 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 96 * A.dp
                    height: 96 * A.dp
                }

                Item {
                    height: 8 * A.dp
                    width: parent.width
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text : "Depth : " + (modelData + 1)
                    type: Constants.largeText
                    color : Constants.black87
                }
            }
        }

    }

}
