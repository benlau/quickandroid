import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Application {
    id : application
    width: 480
    height: 640

    property int activity2DestroyCount : 0

    Component {
        id : activity1
        Activity {
            property string type : "activity1"
        }
    }

    Component {
        id : activity2
        Activity {
            property string type : "activity2"
            noHistory: true

            Component.onDestruction: {
                activity2DestroyCount++;
            }
        }
    }

    TestCase {
        name: "Activity_NoHistory"
        when : windowShown

        function test_default() {
            compare(application.theme , null);
            application.start(activity1);
            wait(200);
            compare(application.current.type,"activity1");
            compare(application.current.enabled,true);

            application.start(activity2);
            wait(200);
            compare(application.current.type,"activity2");
            compare(application.current.enabled,true);

            application.start(activity1);
            wait(200);
            compare(application.current.type,"activity1");
            compare(application.current.enabled,true);

            application.back();
            wait(200);
            compare(application.current.type,"activity1");
            // activity2 is skipped due to noHistory.

            compare(activity2DestroyCount,1);

        }
    }
}
