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
                    objectName: "InitialPage"

                    property int appearCount: 0
                    property int disappearCount: 0

                    Text {
                        anchors.centerIn: parent
                        text: "Initial Page"
                    }

                    onAppear: appearCount++;
                    onDisappear: disappearCount++;
                }

            }
        }

        Component {
            id: page1
            Page {
                objectName: "Page1"
                property int appearCount: 0

                Text {
                    anchors.centerIn: parent
                    text: "Page 1"
                }
                onAppear: appearCount++;

            }
        }

        function test_preview() {
            var stack = component1.createObject(window);
            var initialPage = Testable.search(stack,"InitialPage");
            compare(initialPage.appearCount,1);

            stack.pop(); // It will do nothing
            stack.push(page1);
            var p1 = Testable.search(stack,"Page1");
            compare(p1.appearCount,0);
            compare(initialPage.appearCount,1);
            compare(initialPage.disappearCount,0);

            wait(150);
            compare(p1.appearCount,1);
            compare(initialPage.appearCount,1);
            compare(initialPage.disappearCount,1);

            stack.pop();
            compare(p1.appearCount,1);
            compare(initialPage.appearCount,1);
            compare(initialPage.disappearCount,1);
            wait(150); // p1 is destroyed.
            compare(initialPage.appearCount,2);
            compare(initialPage.disappearCount,1);

            wait(TestEnv.waitTime);
            stack.destroy();
        }
    }

}
