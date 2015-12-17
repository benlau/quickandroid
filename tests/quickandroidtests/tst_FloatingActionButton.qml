import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        anchors.fill: parent
        anchors.topMargin: 48
        anchors.leftMargin: 16

        FloatingActionButton {
            backgroundColor: "Red"
        }

        FloatingActionButton {
            backgroundColor: "blue"
            iconSource: Qt.resolvedUrl("img/ic_action_accept.png")
            iconSourceSize: Qt.size(24 * A.dp,24 * A.dp)
        }

        FloatingActionButton {
            // default
        }

    }


    TestCase {
        name: "FloatingActionButtonTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(TestEnv.waitTime);
        }
    }


}
