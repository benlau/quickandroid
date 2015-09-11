import QtQuick 2.0
import QtQuick.Layouts 1.1
import QuickAndroid 0.1

Activity {
    actionBar: ActionBar {
        title: "Tabs Demonstration"
        onActionButtonClicked: back();
    }

    ListModel {
        id: colorModel
        ListElement { title: "Blue" }
        ListElement { title: "Green" }
        ListElement { title: "Yellow" }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        TabBar {
            id: tabs
            tabs: colorModel

            Layout.fillHeight: false
            Layout.fillWidth: true
        }

        TabView {
            id: tabView
            tabBar:tabs

            Layout.fillHeight: true
            Layout.fillWidth: true

            model: VisualDataModel {
                model: colorModel
                delegate: Rectangle {
                    width: tabView.width
                    height: tabView.height
                    color: model.title
                }
            }
        }

    }

}

