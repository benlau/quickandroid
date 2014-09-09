import QtQuick 2.0
import "qrc:/quickandroid"
import "qrc:/quickandroid/android.js" as A
import "qrc:/quickandroid/res.js" as Res

Activity {

    MaterialShadow {
        asynchronous: true
        anchors.fill: actionBar
        depth: 1
        z: actionBar.z - 1
    }

    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Shadow Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10
    }


    ListView {
        anchors.top : actionBar.bottom
        anchors.topMargin: 8 * A.dp
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        model : 5
        spacing : 16 * A.dp
        delegate : Item {
            width: parent.width
            height: childrenRect.height

            MaterialShadow {
                anchors.fill: whiteFrame
                depth: modelData + 1
                asynchronous: true
            }

            Rectangle {
                id: whiteFrame
                color : "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
                width: 96 * A.dp
                height: 96 * A.dp
            }

            Text {
                anchors.top : whiteFrame.bottom
                anchors.topMargin: 8 * A.dp
                anchors.horizontalCenter: parent.horizontalCenter
                text : "Depth : " + (modelData + 1)
                font.pixelSize: Res.Style.TextAppearance.Large.textSize * A.dp
                color : Res.Style.Black87

            }

        }

    }

}
