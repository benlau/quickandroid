import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {
    width: 120 * A.dp
    height: 48 * A.dp

    QATextInput {
        anchors.fill: parent
        gravity: "bottom"
        background : "qrc:///QuickAndroid/drawable/TextFieldSearchHoloLight.qml"
        text: "Text Input"
    }
}
