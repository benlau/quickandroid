import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Page {
    id: component

    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Bottom Sheet Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

    }

    Button {
        anchors.centerIn: parent
        text: "Press to launch bottom sheet"
        onClicked: bottomSheet.open();
    }

    BottomSheet {
        id : bottomSheet
        parent: component

        Column {
            width: bottomSheet.width

            Item {
                width: bottomSheet.width
                height: 56 * A.dp

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Bottom Sheet"
                    color: Constants.black54
                    x: 16 * A.dp
                }
            }

            ListItem {
                iconSource: A.drawable("ic_camera");
                iconSourceSize: Qt.size(24 * A.dp,24 * A.dp)
                title: "Take Photo"
                showDivider: false
            }

            ListItem {
                iconSource: A.drawable("ic_image");
                iconSourceSize: Qt.size(24 * A.dp,24 * A.dp)
                title: "Pick Image"
                showDivider: false
            }
        }

    }
}
