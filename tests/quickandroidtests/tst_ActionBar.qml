import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        anchors.fill: parent

        ActionBar {
            id : actionBar1
            title : "Super Long Title!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            anchors.fill: undefined

            style.background : "#cddc39" // Lime 500

            menuBar: Drawable {
                id : button1
                source : Qt.resolvedUrl("drawable-xhdpi/ic_action_accept.png")
            }
        }

        ActionBar {
            title: "Actoin Bar 2"

            id: actionBar2
            icon: Qt.resolvedUrl("drawable-hdpi/icon.png")
        }

        ActionBar {
            title: "Actoin Bar 3"

            id: actionBar3
            icon: Qt.resolvedUrl("drawable-hdpi/icon.png")

            content: Rectangle {
                height: actionBar3.height
                width: 200
                color:"red"
                Text {
                    anchors.fill: parent
                    text: "Content item"
                }
            }

            menuBar: Drawable {
                source : Qt.resolvedUrl("drawable-xhdpi/ic_action_accept.png")
            }
        }

    }

    Rectangle {
        height: parent.height
        width: 1
        x: 16
        color: "red"
    }

    Rectangle {
        height: parent.height
        width: 1
        x: 72
        color: "red"
    }

    TestCase {
        name: "ActionBarTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(TestEnv.waitTime);
        }
    }

}
