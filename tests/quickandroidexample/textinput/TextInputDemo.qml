import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Activity {
    id: activity

    MaterialShadow {
        asynchronous: true
        anchors.fill: actionBar
        depth: 1
        z: actionBar.z - 1
    }

    ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Text Input Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10
    }

    Column {
        anchors.top: actionBar.bottom
        anchors.left: parent.left
        anchors.leftMargin: 16 * A.dp

        QATextInput {
            width: activity.width - 32 * A.dp
            height: 48 * A.dp
            text: "Text Input without any style"
        }

        QATextInput {
            width: activity.width - 32 * A.dp
            height: 48 * A.dp
            gravity: "bottom"
            background : "qrc:///QuickAndroid/drawable/TextFieldSearchHoloLight.qml"
            text: "Text Input with searching field background"
        }

        QATextInput {
            width: 120 * A.dp
            height: 48 * A.dp
            gravity: "bottom"
            background : "qrc:///QuickAndroid/drawable/TextFieldSearchHoloLight.qml"
            text: "When content is longer than the input"
        }

        QATextInput {
            width: 150 * A.dp
            height: 48 * A.dp
            gravity: "bottom"
            background : "qrc:///QuickAndroid/drawable/TextFieldSearchHoloLight.qml"
            text: "Smaller text size and color"
            style.textStyle: TextStyle {
                textColor : "red"
                textSize: 14
            }
        }

        QATextInput {
            width: 150 * A.dp
            height: 48 * A.dp
            gravity: "center"
            background : "qrc:///QuickAndroid/drawable/TextFieldSearchHoloLight.qml"
            text: "Gravity center"
            style.textStyle: TextStyle {
                textColor : "blue"
                textSize: 14
            }

        }

        QATextInput {
            width: 150 * A.dp
            height: 48 * A.dp
            gravity: "bottom"
            background : "qrc:///QuickAndroid/drawable/TextFieldSearchHoloLight.qml"
            text: ""
//            style.textStyle: {
//                textColor : "blue"
//                textSize: 14
//            }
            style.textStyle.textColor: "blue"
            style.textStyle.textSize: 14
        }

    }

}
