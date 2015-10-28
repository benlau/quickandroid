import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id: window
    width : 480
    height : 640

    TestCase {
        id: testCase
        name: "PageStackTests"
        when : windowShown

        Component {
            id: component1

            PageStack {
                anchors.fill: parent
                initialPage: Page {
                    Text {
                        anchors.centerIn: parent
                        text: "Page1"
                    }
                }

            }
        }

        function test_preview() {
            var stack = component1.createObject(window);
            wait(TestEnv.waitTime);

            stack.destroy();
        }
    }

}
