import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    property var appeardOrder: new Array

    SwipeView {
        id: swipeView
        anchors.fill: parent
        delegate: Rectangle {
            width: swipeView.width
            height: swipeView.height
            color: modelData

            signal appear();
            signal disappear();
            property bool isAppeared : false
            opacity: isAppeared ? 1 : 0.5

            onAppear: {
                isAppeared = true;
                appeardOrder.push(modelData);
            }

            onDisappear: {
                isAppeared = false;
            }

        }
        model: ["yellow","blue","red"];
    }

    TestCase {
        name: "SwipeViewTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            compare(appeardOrder.length,0);
            wait(100);
            compare(appeardOrder.length,1);
            wait(200);
            compare(swipeView.contentX,0);
            swipeView.currentIndex = 2;
            wait(100);

            compare(appeardOrder.length,1);
            compare(swipeView.contentX > 0,true);
            compare(swipeView.contentX < rect.width,true);
            wait(swipeView.highlightMoveDuration - 100 + 50);
            compare(swipeView.contentX,rect.width * swipeView.currentIndex);
            compare(appeardOrder.length,2);

            wait(TestEnv.waitTime);
        }
    }


}
