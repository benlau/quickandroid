import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {
    width: spinner.width
    height: 48 * A.dp

    ListModel {
        id : spinnerModel
        ListElement {
            title : "Sort by Time"
        }
        ListElement {
            title : "Sort by Alphabetical Order"
            textSize: "Medium"
            height : 48
        }
    }

    Spinner {
        id: spinner
        model: spinnerModel
    }
}
