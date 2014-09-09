import QtQuick 2.0
import "qrc:/quickandroid"
import "qrc:/quickandroid/android.js" as A
import "qrc:/quickandroid/res.js" as Res

Rectangle {
    width: 100
    height: 100
    color : "#ffffff"

    MaterialShadow {
        anchors.fill: parent
        z : -10
        depth : 5
        asynchronous: true
    }
}
