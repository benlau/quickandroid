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
        title: qsTr("Spinner Demo")
        showTitle: false

        onActionButtonClicked: back();

        content: Spinner {
            model: spinnerModel
            onItemSelected: {
                console.log(model.cmd);
                label.text = model.title
            }
        }
    }

    ListModel {
        id : spinnerModel
        ListElement {
            title : "Sort by Time"
            cmd : "sortByTime"
        }
        ListElement {
            title : "Sort by Alphabetical Order"
            textSize: "Medium"
            height : 48
            cmd: "sortByAlpha"
        }
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
