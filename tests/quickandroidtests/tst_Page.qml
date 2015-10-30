import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id: window
    width : 480
    height : 640

    TestCase {
        id: testCase
        name: "PageTests"
        when : windowShown
        width : 480
        height : 640

        Component {
            id: page1
            Page {
                anchors.fill: parent

                actionBar: ActionBar {
                    title: "Page 1"
                }

                Rectangle {
                    objectName: "Rectangle";
                    anchors.fill: parent
                    color: "green"
                }
            }
        }

        function test_preview() {
            var page = page1.createObject(window);
            page.visible = true;
            console.log(page.opacity);
            compare(page.width,480);
            compare(page.height,640);

            var actionBar = Testable.search(page,"ActionBar");
            compare(actionBar.width,480);
            compare(actionBar.height,56);
            var rect = Testable.search(page,"Rectangle");
            compare(rect.width,480);
            compare(rect.height,640-56);

            wait(TestEnv.waitTime);
        }
    }
}
