import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    ActionBar {
        id : actionBar1
        title : "Super Long Title!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

        menuBar: Drawable {
            id : button1
            source : Qt.resolvedUrl("drawable-xhdpi/ic_action_accept.png")
        }
    }

    TestCase {
        name: "ActionBarTests"
        width : 480
        height : 480
        when : windowShown

        function test_basic() {
            wait(100);
//            console.log(actionBar1.menuBar.x,button1.x);
//            wait(60000);
        }
    }

}
