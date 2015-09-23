import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : window
    width: 480
    height: 640

    TabBar {
        id: tabBarItem
        tabs: [
             { title: "YELLOW" },
             { title: "BLUE" },
             { title: "RED" }
        ]
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    TabView {
        id: tabView
        tabBar: tabBarItem
        anchors.top: tabBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        delegate: Tab {
            width: tabView.width
            height: tabView.height

            Rectangle {
                anchors.fill: parent
                color: modelData
                opacity: isAppeared ? 1 : 0.5
            }
        }
        model: ["yellow","blue","red"];
    }

    TestCase {
        name: "TabViewTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);
            compare(tabBarItem.currentIndex,0);

            wait(TestEnv.waitTime);
        }
    }


}
