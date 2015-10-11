import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    width: 480
    height: 640

    Component {
        id: activityCreator;
        Activity {

            property int appearCount: 0
            property int disappearCount: 0

            onAppear: appearCount++;
            onDisappear: disappearCount++;
        }
    }

    Application {
        id: application
        anchors.fill: parent

    }


    TestCase {
        name: "ActivityTests_appear"
        when : windowShown

        function test_preview() {
            wait(200);
            compare(application.current,undefined);
            application.start(activityCreator);

            wait(300);
            var activity1 = application.current;
            compare(activity1.appearCount,1);
            compare(activity1.disappearCount,0);

            application.start(activityCreator);
            wait(300);
            var activity2 = application.current;
            compare(activity1 !== activity2 ,true);

            compare(activity1.appearCount,1);
            compare(activity1.disappearCount,1);
            compare(activity2.appearCount,1);
            compare(activity2.disappearCount,0);

            application.back();
            wait(300);

            compare(activity1.appearCount,2);
            compare(activity1.disappearCount,1);

            wait(TestEnv.waitTime);
        }

    }

}

