import QtQuick 2.0
import "qrc:/quickandroid"
import "qrc:/quickandroid/item"
import "qrc:/quickandroid/android.js" as A
import "qrc:/quickandroid/res.js" as Res

DropDownList {
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
}
