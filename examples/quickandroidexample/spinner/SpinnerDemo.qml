import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Activity {

    actionBar: ActionBar {
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
        color : Constants.black87
        font.pixelSize: Style.theme.largeText.textSize
    }
}
