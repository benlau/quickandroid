import QtQuick 2.2
import QtQuick.Window 2.1
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./theme"

Activity {

    actionBar: ActionBar {
        id : actionBar
        title: "Component List"
        showIcon: false;
        actionButtonEnabled: false
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
            description: "Shadow, Paper components"
        }

        ListElement {
            name : "Drop Down Menu"
            demo: "dropDownMenu/DropDownMenuDemo.qml"
            description: "DropDownMenu components"
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
            name: "Floating Action Button"
            demo: "floatingactionbutton/FloatingActionButtonDemo.qml"
            description: "Circled button floating above UI"
        }

        ListElement {
            name : "Inter Process Communication between Android/C++"
            preview : ""
            demo : "notification/NotificationDemo.qml"
            description: "Sending notification via System Dispatcher"
        }

        ListElement {
            name : "Tabs"
            description: "TabBar, TabView"
            demo : "tabs/TabsDemo.qml"
        }


    }

    VisualDataModel {
        id: visualDataModel
        delegate: ListItem {
            title: model.name
            subtitle: model.description
            onClicked: {
                start(Qt.resolvedUrl(model.demo));
            }
        }

        model: listModel;
    }

    ListView {
        anchors.fill: parent

        model : visualDataModel
    }

}
