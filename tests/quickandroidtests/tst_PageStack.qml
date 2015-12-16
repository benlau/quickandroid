import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.Private 0.1
import "../../QuickAndroid/utils.js" as Utils

Rectangle {
    id: window
    width : 480
    height : 640

    TestSuite {
        id: testCase
        name: "PageStackTests"
        when : windowShown

        Component {
            id: pageStackCreator1

            PageStack {
                anchors.fill: parent
                property var pushedList: new Array

                property var poppedList: new Array

                onPushed: pushedList.push(page);
                onPopped: poppedList.push(page);

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
            var stack = pageStackCreator1.createObject(window);
            stack.asynchronous = false;

            var initialPage = Testable.search(stack,"InitialPage");
            var pushAnimFinished = false;
            compare(initialPage.appearCount,1);
            compare(stack.pushedList.length,1);
            compare(stack.poppedList.length,0);

            stack.pop(); // It will do nothing
            compare(stack.count,1);
            compare(stack.pushedList.length,1);
            compare(stack.poppedList.length,0);

            var p1 = stack.push(page1);
            p1._transition.presentTransition.onStopped.connect(function() {
                pushAnimFinished = true;
            });
            compare(stack.count,2);
            compare(stack.pushedList.length,2);
            compare(stack.poppedList.length,0);
            compare(p1.appearCount,0);
            compare(initialPage.appearCount,1);
            compare(initialPage.disappearCount,0);
            compare(stack.topPage,p1);

            wait(500);
            compare(pushAnimFinished,true);
            compare(initialPage.appearCount,1);
            compare(initialPage.disappearCount,1);
            compare(stack.topPage,p1);
            compare(p1.appearCount,1);

            stack.pop();
            compare(stack.count,1);
            compare(p1.appearCount,1);
            compare(stack.pushedList.length,2);
            compare(stack.poppedList.length,1);
            compare(initialPage.appearCount,1);
            compare(initialPage.disappearCount,1);
            wait(500);
            // p1 is destroyed.
            compare(initialPage.appearCount,2);
            compare(initialPage.disappearCount,1);

            wait(TestEnv.waitTime);
            stack.destroy();
        }

        function test_noHistory() {
            var stack = pageStackCreator1.createObject(window);
            var initialPage = Testable.search(stack,"InitialPage");
            compare(initialPage.appearCount,1);

            var p1 = page1.createObject(window);
            var p2 = page1.createObject(window);
            p1.noHistory = true;

            compare(stack.pages.length,1);
            stack.push(p1,{},false);
            compare(stack.pages.length,2);
            stack.push(p2,{},false);
            compare(stack.pages.length,2);
            stack.destroy();
        }

        function test_present() {
            var stack = pageStackCreator1.createObject(window);
            stack.asynchronous = false;

            var initialPage = Testable.search(stack,"InitialPage");
            compare(initialPage.stack,stack);
            compare(initialPage.appearCount,1);
            compare(stack.count,1);

            var p1 = initialPage.present(page1,{},false)
            compare(stack.pages.length,2);
            compare(stack.count,2);

            p1.dismiss(false);
            compare(stack.count,1);
            stack.destroy();
        }

        Component {
            id: component2
            PageStack {
                initialPage: Page {
                    noHistory: true

                    Overlay {
                    }
                }
            }
        }

        function test_noHistory_initialPage() {
            var stack = component2.createObject(window);
            stack.asynchronous = false;

            compare(stack.count,1);
            var p1 = stack.push(page1,{});
            compare(stack.count,1);
            compare(stack.topPage,p1);
            stack.destroy();
        }

        Component {
            id: itemCreator;
            Item {

            }
        }

        function test_error() {
            var stack = pageStackCreator1.createObject(window);
            stack.asynchronous = false;
            // push a not page item
            stack.push(itemCreator);
            compare(stack.running, false);
            stack.destroy();
        }

        function test_queue() {
            var stack = pageStackCreator1.createObject(window);
            stack.asynchronous = false;
            stack.queueEnabled = true;

            var initialPage = Testable.search(stack,"InitialPage");
            compare(initialPage.appearCount,1);
            compare(stack.running, false);

            var p1 = stack.push(page1);
            compare(p1 !== undefined, true);
            compare(stack.running, true);
            compare(stack.pages.length,2);

            var p2 = stack.push(page1);
            compare(stack.pages.length,2);
            compare(p2 !== undefined, true);

            waitFor(stack, "running", false);
            compare(stack.running, false);
            compare(stack.pages.length,3);

            stack.pop();
            compare(stack.pages.length,2);

            stack.pop();
            compare(stack.pages.length,2);

            compare(stack.running, true);
            waitFor(stack, "running", false);
            compare(stack.running, false);

            compare(stack.pages.length, 1);

            stack.destroy();

        }

        function test_createObject_asynchronous() {
            var incubator = Utils.createObject(page1, window, {}, true);
            compare(incubator.status !== undefined, true);
            compare(incubator.object !== undefined, true);
        }

        function isIncubator(object) {
            return object.status !== undefined && object.object !== undefined;
        }

        function test_push_asynchronous() {
            var stack = pageStackCreator1.createObject(window);
            stack.asynchronous = true;
            stack.queueEnabled = true;
            var initialPage = Testable.search(stack,"InitialPage");
            compare(initialPage.appearCount,1);
            compare(stack.running, false);

            var p1 = stack.push(page1);
            compare(p1 !== undefined, true);
            compare(isIncubator(p1), true);
            compare(stack.running, true);

            // It is still creating and not pushed. So it is "1"
            compare(stack.pages.length,1);

            var p2 = stack.push(page1);
            compare(isIncubator(p2), true);
            compare(stack.pages.length,1);
            compare(p2 !== undefined, true);

            waitFor(stack, "running", false);
            compare(stack.running, false);
            compare(stack.pages.length,3);

            stack.pop();
            compare(stack.pages.length,2);

            stack.pop();
            compare(stack.pages.length,2);

            compare(stack.running, true);
            waitFor(stack, "running", false);
            compare(stack.running, false);

            compare(stack.pages.length, 1);

            stack.destroy();
        }

        function test_push_string_asynchronous() {
            var stack = pageStackCreator1.createObject(window);
            stack.asynchronous = true;
            stack.queueEnabled = true;

            var initialPage = Testable.search(stack,"InitialPage");
            compare(initialPage.appearCount,1);
            compare(stack.running, false);

            var p1 = stack.push(Qt.resolvedUrl("./components/DummyPage.qml"));
            compare(p1 !== undefined, true);
            compare(stack.running, true);

            // It is still creating and not pushed. So it is "1"
            compare(stack.pages.length,1);

            var p2 = stack.push(Qt.resolvedUrl("./components/DummyPage.qml"));
            compare(stack.pages.length,1);
            compare(p2 !== undefined, true);

            waitFor(stack, "running", false);
            compare(stack.running, false);
            compare(stack.pages.length,3);

            stack.pop();
            compare(stack.pages.length,2);

            stack.pop();
            compare(stack.pages.length,2);

            compare(stack.running, true);
            waitFor(stack, "running", false);
            compare(stack.running, false);

            compare(stack.pages.length, 1);

            stack.destroy();
        }

        function test_disableQueue() {
            var stack = pageStackCreator1.createObject(window);
            stack.asynchronous = true;
            stack.queueEnabled = false;
            var initialPage = Testable.search(stack,"InitialPage");
            compare(initialPage.appearCount,1);
            compare(stack.running, false);

            var p1 = stack.push(page1);
            compare(stack.running, true);
            var p2 = stack.push(page1);
            compare(p2, undefined);
            waitFor(stack, "running", false);
            compare(stack.pages.length,2);


            stack.destroy();
        }
    }

}
