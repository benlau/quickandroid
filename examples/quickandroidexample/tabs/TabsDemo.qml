import QtQuick 2.0
import QtQuick.Layouts 1.1
import QuickAndroid 0.1

Page {
    actionBar: ActionBar {
        title: "Tabs Demonstration"
        onActionButtonClicked: back();
        height: material.unitHeight + tabs.height

        TabBar {
            id: tabs
            width: parent.width
            tabs: colorModel
            anchors.bottom: parent.bottom
        }
    }

    property var colorModel: [
        { title: "Blue" },
        { title: "Green" },
        { title: "Yellow" }
    ]

    TabView {
        id: tabView
        tabBar:tabs

        anchors.fill: parent

        model: VisualDataModel {
            model: colorModel
            delegate: Rectangle {
                width: tabView.width
                height: tabView.height
                color: modelData.title
            }
        }
    }

}

