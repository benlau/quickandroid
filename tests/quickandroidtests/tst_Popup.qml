import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.item 0.1

Activity {
    id : window
    width: 480
    height: 640

    actionBar: ActionBar {
        title: "Popup Tests"
    }

    Button {
        id: button1
        text: "Launch"
        x: 400
        y: 50
        onClicked: {
            popup1.open()
        }
    }

    Popup {
        id: popup1

        anchorPoint : Constants.leftTop
        anchorView: button1

        Rectangle {
            width: 100
            height: 100
        }
    }

    TestCase {
        name: "PopupTests"
        width : 480
        height : 480
        when : windowShown

        function test_rightTop() {
            popup1.anchorView = actionBarItem
            popup1.anchorPoint = Constants.rightTop
            popup1.open();
            wait(300);

            compare(popup1.paper.x,372);
            compare(popup1.paper.y,8);
            wait(TestEnv.waitTime);
        }

        function test_preview() {
            wait(200);

            var root = popup1._topmost();
            compare(root.width,480);
            compare(root.height,640);
//            compare(popup1.paper.width,100);

            // It won't set the height when closed
            compare(popup1.paper.height,0);

            wait(TestEnv.waitTime);
        }
    }


}
