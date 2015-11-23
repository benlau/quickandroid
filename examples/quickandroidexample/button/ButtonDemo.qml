import QtQuick 2.0
import QtQuick.Controls 1.3
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Page {
    id: component

    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Button Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10
    }

    ScrollView {
        anchors.fill: parent

        Column {
            width: component.width

            ListItem {
                title: "Button"
                subtitle: "Text only"
                width: component.width
                interactive: false
                rightIcon: Button {
                    text: "Click Me"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            ListItem {
                title: "Button"
                subtitle: "Text Only [Disabled]"
                interactive: false
                rightIcon: Button {
                    text: "Click Me"
                    anchors.verticalCenter: parent.verticalCenter
                    enabled: false
                }
            }

            ListItem {
                title: "Button"
                subtitle: "Icon Only"
                interactive: false
                rightIcon: Button {
                    iconSource: A.drawable("ic_image");
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            ListItem {
                title: "Button"
                subtitle: "Icon Only [Disabled]"
                interactive: false
                rightIcon: Button {
                    iconSource: A.drawable("ic_image");
                    enabled: false
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            ListItem {
                title: "Button"
                subtitle: "Text and Icon"
                interactive: false
                rightIcon: Button {
                    text: "Click Me"
                    iconSource: A.drawable("ic_image");
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            ListItem {
                title: "Button"
                subtitle: "Text and Icon [Disabled]"
                interactive: false
                rightIcon: Button {
                    text: "Click Me"
                    iconSource: A.drawable("ic_image");
                    anchors.verticalCenter: parent.verticalCenter
                    enabled: false
                }
            }

            ListItem {
                title: "RaisedButton"
                subtitle: "Text Only"
                interactive: false
                rightIcon: RaisedButton {
                    text: "Click Me"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            ListItem {
                title: "RaisedButton"
                subtitle: "Text Only [Disabled]"
                interactive: false
                rightIcon: RaisedButton {
                    text: "Click Me"
                    enabled: false
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

        }

    }



}
