import QtQuick 2.2
import QtQuick.Window 2.1
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./theme"

Activity {

    actionBar: ActionBar {
        id : actionBar
        iconSource: A.drawable("ic_menu",Constants.black87)
        title: "Component List"
        showIcon: false
        actionButtonEnabled: false
    }

    ListModel {
        id: listModel
        objectName: "ComponentListModel"

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
            name : "Drop Down Menu"
            demo: "dropDownMenu/DropDownMenuDemo.qml"
            description: "DropDownMenu components"
        }

        ListElement {
            name: "Floating Action Button"
            demo: "floatingactionbutton/FloatingActionButtonDemo.qml"
            description: "Circled button floating above UI"
        }

        ListElement {
            name: "ListItem"
            demo: "listitem/ListItemDemo.qml"
            description: "Lists: Control"
        }

        ListElement {
            name : "Notification Example"
            preview : ""
            demo : "notification/NotificationDemo.qml"
            description: "Using SystemDispatcher - IPC between C++ and Java"
        }

        ListElement {
            name : "Shadow"
            preview : "shadow/ShadowPreview.qml"
            demo: "shadow/ShadowDemo.qml"
            description: "Shadow, Paper components"
        }

        ListElement {
            name : "Tabs"
            description: "TabBar, TabView"
            demo : "tabs/TabsDemo.qml"
        }

        ListElement {
            name : "TextField"
            description: "TextField"
            demo : "textField/TextFieldDemo.qml"
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
