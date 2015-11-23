import QtQuick 2.0
import QuickAndroid 0.1
import "../theme"

Page {

    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Drawable Provider Demo")
        showTitle: true

        onActionButtonClicked: back();
    }

    ListModel {
        id: listModel
        ListElement {
            source :  "image://drawable/ic_android_black_48dp"
            title: "No tintColor"
        }

        ListElement {
            source : "image://drawable/ic_android_black_48dp?tintColor=red"
            title: "tintColor='red'"
        }

        ListElement {
            source : "image://drawable/ic_android_black_48dp?tintColor=5D76DB"
            title: "tintColor=5D76DB"
        }

        ListElement {
            source : "image://drawable/ic_android_black_48dp?tintColor=7F5D76DB"
            title: "tintColor=7F5D76DB"
        }

    }

    ListView {
        anchors.fill: parent

        model : listModel
        delegate: ListItem {
            title: model.title
            subtitle : model.source
            height: 72 * A.dp
            color: "#9FFFFFFF"
            interactive: false

            icon: Image {
                anchors.verticalCenter: parent.verticalCenter
                width: 48 * A.dp
                height: 48 * A.dp
                source: model.source
            }
        }
    }


}

