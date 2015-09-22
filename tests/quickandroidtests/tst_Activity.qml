import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    width: 480
    height: 640

    Column {
        anchors.fill: parent

        Activity {
            height: 100
            width: parent.width

            Item {
                id: content1
                anchors.fill: parent
            }
        }

        Activity {
            height: 100
            width: parent.width
            actionBar: ActionBar {
                id: actionBar2;
                title: "Activity 2";
            }

            Item {
                id: content2
                anchors.fill: parent
            }
        }

    }


    TestCase {
        name: "ActivityTests"
        when : windowShown

        function test_preview() {
            wait(200);
//            wait(TestEnv.waitTime);

            compare(actionBar2.width,480);

            compare(content1.width,480);
            compare(content1.height,100);
            compare(content2.width,480);
            compare(content2.height,100 - 56);

            wait(TestEnv.waitTime);
        }

    }

}

