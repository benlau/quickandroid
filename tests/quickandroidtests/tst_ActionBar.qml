import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Rectangle {
    id : window
    width: 480
    height: 640

    Column {
        anchors.fill: parent

        ActionBar {
            width: window.width
            id : actionBar1
            title : "Super Long Title - 01234567890123456789012345678901234567890123456789"
            anchors.fill: undefined

            style.background : "#cddc39" // Lime 500

            menuBar: Drawable {
                id : button1
                source : Qt.resolvedUrl("drawable-xhdpi/ic_action_accept.png")
            }
        }

        ActionBar {
            title: "Actoin Bar 2"
            width: window.width

            id: actionBar2
            iconSource: Qt.resolvedUrl("drawable-hdpi/icon.png")
            iconSourceSize: Qt.size(32 * A.dp , 32 * A.dp)
        }

        ActionBar {
            title: "Actoin Bar 3"
            width: window.width

            id: actionBar3
            iconSource: Qt.resolvedUrl("drawable-hdpi/icon.png")

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

        ActionBar {
            title: "Actoin Bar 4"
            width: window.width
            background: Constants.white100
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
