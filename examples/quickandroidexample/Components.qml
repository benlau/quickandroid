import QtQuick 2.2
import QtQuick.Window 2.1
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./theme"

Page {
    objectName: "ComponentPage";

    property var pages: [
        {
            name: "BottomSheet",
            demo: "bottomsheet/BottomSheetDemo.qml",
            description: "Material Design Bottom Sheet"
        },

        {
            name: "Button",
            demo: "button/ButtonDemo.qml",
            description: "Button Component"
        },

        {
            name : "Dialog",
            demo: "dialog/DialogDemo.qml",
            description: "Dialog Component"
        },

        {
            name: "Drawable Provider",
            demo: "drawableprovider/DrawableProviderDemo.qml",
            description: "Loading drawable resource in Android style"
        },

        {
            name : "Drop Down Menu",
            demo: "dropDownMenu/DropDownMenuDemo.qml",
            description: "DropDownMenu components"
        },

        {
            name: "Floating Action Button",
            demo: "floatingactionbutton/FloatingActionButtonDemo.qml",
            description: "Circled button floating above UI"
        },

        {
            name: "Image Picker",
            demo: "imagePicker/ImagePickerDemo.qml",
            description: "Pick interface via Java language binding"
        },

        {
            name: "ListItem",
            demo: "listitem/ListItemDemo.qml",
            description: "Lists: Control"
        },

        {
            name : "Notification Example",
            demo : "notification/NotificationDemo.qml",
            description: "SystemDispatcher - Communication between C++ and Java"
        },

        {
            name : "Shadow",
            demo: "shadow/ShadowDemo.qml",
            description: "Shadow, Paper components"
        },

        {
            name : "Tabs",
            description: "TabBar, TabView",
            demo : "tabs/TabsDemo.qml"
        },

        {
            name : "TextField",
            description: "TextField",
            demo : "textField/TextFieldDemo.qml"
        }
    ];

    actionBar: ActionBar {
        id : actionBar
        iconSource: A.drawable("ic_menu",Constants.black87)
        title: "Component List"
        showIcon: false
        actionButtonEnabled: false
    }

    VisualDataModel {
        id: visualDataModel
        delegate: ListItem {
            title: modelData.name
            subtitle: modelData.description
            onClicked: {
                present(Qt.resolvedUrl(modelData.demo));
            }
        }

        model: pages;
    }

    ListView {
        anchors.fill: parent

        model : visualDataModel
    }

}
