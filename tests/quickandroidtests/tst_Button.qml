import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.item 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        anchors.fill: parent

        Button {
            text: "Button 1"
        }
        Button {
            text: "Button 2 - 1234567890"
            textColor: "blue"
            textSize: 24
        }

    }

    TestCase {
        name: "ButtonTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);

            wait(TestEnv.waitTime);
        }
    }


}
