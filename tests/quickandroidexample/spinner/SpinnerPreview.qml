import QtQuick 2.0
import "qrc:/quickandroid"
import "qrc:/quickandroid/android.js" as A
import "qrc:/quickandroid/res.js" as Res

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
