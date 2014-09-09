import QtQuick 2.0
import "qrc:/quickandroid"
import "qrc:/quickandroid/android.js" as A
import "qrc:/quickandroid/res.js" as Res

Activity {

    MaterialShadow {
        asynchronous: true
        anchors.fill: actionBar
        depth: 1
    }

    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("PopupMenu Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

        menuBar : QuickButton {
            icon : Qt.resolvedUrl("../drawable-xxhdpi/ic_menu.png")
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
        color : Res.Style.Black87
        font.pixelSize: Res.Style.TextAppearance.Large.textSize * A.dp
    }

}
