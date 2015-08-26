import QtQuick 2.0
import QuickAndroid 0.1

Activity {
    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Drawable Provider Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

        MaterialShadow {
            asynchronous: true
            anchors.fill: actionBar
            depth: 1
            z: -1
        }
    }

    ListModel {
        id: listModel
        ListElement {
            source : "image://drawable/ic_android_black_48dp"
            title: "Default"
        }

        ListElement {
            source : "image://drawable/ic_android_black_48dp?tintColor=red"
            title: "Set tintColor to 'red'"
        }

        ListElement {
            source : "image://drawable/ic_android_black_48dp?tintColor=5D76DB"
            title: "Set tintColor to 5D76DB"
        }

    }

    ListView {
        anchors.fill: parent

        model : listModel
        delegate: ListItem {
            title: model.title
            subtitle : model.source
            height: 72 * A.dp

            icon: Image {
                anchors.verticalCenter: parent.verticalCenter
                width: 48 * A.dp
                height: 48 * A.dp
                source: model.source
            }
        }
    }


}

