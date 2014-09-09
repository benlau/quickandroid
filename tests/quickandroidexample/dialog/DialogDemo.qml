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
        title: qsTr("Dialog Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

    }

    Text {
        id: label
        text : "Press to launch dialog"
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color : Res.Style.Black87
        font.pixelSize: Res.Style.TextAppearance.Large.textSize * A.dp

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            dialog.open();
        }
    }

    AlertDialog {
        id: dialog
        anchors.centerIn: parent
        message: "What do think about QuickAndroid?"
        z: 20
    }
}
