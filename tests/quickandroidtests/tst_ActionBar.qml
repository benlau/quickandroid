import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    ActionBar {
        id : actionBar1
        title : "Super Long Title!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

        style.background : "#cddc39" // Lime 500

        menuBar: Drawable {
            id : button1
            source : Qt.resolvedUrl("drawable-xhdpi/ic_action_accept.png")
        }
    }

    TestCase {
        name: "ActionBar"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(TestEnv.waitTime);
        }
    }

}
