import QtQuick 2.2
import QtQuick.Window 2.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Activity {

    actionBar: ActionBar {
        id : actionBar
        title: "Quick Android Example Program"
        actionButtonEnabled: false

        MaterialShadow {
            asynchronous: true
            anchors.fill: actionBar
            depth: 1
            z: -1
        }
    }

    Component {
        id: listItem
        ListItem {
            title: model.name
            subtitle: model.description

            icon: Rectangle {
                id: preview
                anchors.verticalCenter: parent.verticalCenter
                width: 48 * A.dp
                height: 48 * A.dp
                border.color: "#1A000000"
                color : "#999999"

                Loader {
                    id : loader
                    x: 1 * A.dp
                    y: 1 * A.dp
                    asynchronous: true
                    visible: false
                    source: Qt.resolvedUrl(model.preview)
                    onLoaded: visible = true

                    transform: RectToRectMatrix {
                        source: Qt.rect(0,0,loader.width + 8 * A.dp,loader.height +8 *A.dp)
                        dest: Qt.rect(0,0,preview.width - x * 2,preview.height - x * 2)
                    }
                }
            }

            onClicked: {
                start(Qt.resolvedUrl(model.demo));
            }
        }
    }

    ListModel {
        id: listModel
        ListElement {
            name : "Spinner"
            preview : "spinner/SpinnerPreview.qml"
            demo: "spinner/SpinnerDemo.qml"
            description: "Spinner Example"
        }

        ListElement {
            name : "Shadow"
            preview : "shadow/ShadowPreview.qml"
            demo: "shadow/ShadowDemo.qml"
            description: "Material Design Shadow"

        }

        ListElement {
            name : "Popup Menu"
            preview : "popupmenu/PopupMenuPreview.qml"
            demo: "popupmenu/PopupMenuDemo.qml"
            description: "PopupArea , PopupMenu components"
        }

        ListElement {
            name : "Dialog"
            preview : "dialog/DialogPreview.qml"
            demo: "dialog/DialogDemo.qml"
            description: "Dialog Component"
        }

        ListElement {
            name: "Drawable Provider"
            demo: "drawableprovider/DrawableProviderDemo.qml"
            description: "Loading drawable resource in Android style"
        }

        ListElement {
            name: "ListItem"
            demo: "listitem/ListItemDemo.qml"
            description: "Lists: Control"
        }

        ListElement {
            name: "FloatingActionButton"
            demo: "floatingactionbutton/FloatingActionButtonDemo.qml"
            description: "FloatingActionButton"
        }

        /*
        ListElement {
            name : "Text Input"
            preview : "textinput/TextInputPreview.qml"
            demo: "textinput/TextInputDemo.qml"
        }

        ListElement {
            name : "Switch"
            preview : "switch/SwitchPreview.qml"
            demo : "switch/SwitchDemo.qml"
        }
        */

        ListElement {
            name : "Notification"
            preview : ""
            demo : "notification/NotificationDemo.qml"
            description: "Sending notification via System Dispatcher"
        }

    }

    ListView {
        anchors.fill: parent

        model : listModel
        delegate: listItem
    }

}
