import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.item 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

//    Tabs {
//        id: tabs
//        tabs: ListModel {
//            ListElement { title: "YELLOW" }
//            ListElement { title: "BLUE" }
//            ListElement { title: "RED" }
//        }
//        anchors.top: parent.top
//        anchors.left: parent.left
//        anchors.right: parent.right
//    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        delegate: Rectangle {
            width: swipeView.width
            height: swipeView.height
            color: modelData
        }
        model: ["yellow","blue","red"];
    }

    TestCase {
        name: "SwipeViewTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);

            wait(TestEnv.waitTime);
        }
    }


}
