import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import "../theme"

Activity {

    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("PopupMenu Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

        menuBar : QuickButton {
            icon : "image://drawable/ic_menu.png"
            onClicked:  {
                popupMenu.toggle();
            }
            opacity: 0.87
        }
    }


    PopupMenu {
        id : popupMenu
        anchors.right: parent.right
        anchors.top: actionBar.bottom
        model : ListModel {
            ListElement {
                title : "Share"
            }
            ListElement {
                title : "Copy"
            }
            ListElement {
                title : "Delete"
            }
        }
        onItemSelected: {
            popupMenu.active = false;
            label.text = model.title
        }
        z: 10000
    }

    Text {
        id: label
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color : Style.theme.black87
        font.pixelSize: Style.theme.largeText.textSize * A.dp
    }

}
