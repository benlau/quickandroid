import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.item 0.1

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
