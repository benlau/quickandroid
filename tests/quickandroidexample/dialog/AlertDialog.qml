import QtQuick 2.0
import "qrc:/quickandroid"
import "qrc:/quickandroid/android.js" as A
import "qrc:/quickandroid/res.js" as Res

// It is not part of QuickAndroid yet. Still tuning the size
Dialog {
    id: dialog

    property string message
    radius: 2 * A.dp

    width : Math.min(6 * 48 * A.dp,parent.width * 0.8)
    height: column.height

    MaterialShadow {
        anchors.fill: dialog
        asynchronous: true
        depth: 3
        z: -100
        visible: dialog.opacity === 1
    }

    Column {
        id: column
        anchors.centerIn: parent
        Item {
            width: dialog.width
            height: 2 * 48 * A.dp

            Text {
                text : dialog.message
                anchors.fill: parent
                anchors.margins: 16 * A.dp
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Res.Style.TextAppearance.textSize * A.dp
                wrapMode : Text.WordWrap
                color : Res.Style.Black87
            }
        }

        Rectangle {
            height: 1 * A.dp
            width: dialog.width
            color : "#1A000000"
        }

        Row {
            width: dialog.width
            height: 48 * A.dp

            QuickButton {
                text: qsTr("Cancel")
                width: parent.width / 2 - 1 * A.dp
                height: parent.height
                onClicked: {
                    dialog.reject();
                }
            }

            Rectangle {
                height: parent.height
                width : 1 * A.dp
                color : "#1A000000"
            }

            QuickButton {
                text: qsTr("OK")
                width: parent.width/ 2
                height: parent.height
                onClicked: {
                    dialog.accept();
                }
            }

        }
    }
}
