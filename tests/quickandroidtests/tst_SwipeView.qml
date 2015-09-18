import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

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
