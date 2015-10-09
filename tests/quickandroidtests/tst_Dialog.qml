import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Activity {
    id : rect
    width: 480
    height: 640

    Button {
        anchors.centerIn: parent
        text: "Click here top launch dialog"
        onClicked: {
            dialog1.open();
        }
    }

    Dialog {
        id: dialog1
        title: "Dialog"

        rejectButtonText: "CANCEL"
        acceptButtonText: "OK"

        Column {
            Repeater {
                model: 10
                delegate: Text {
                    text: "Testing..."
                }
            }

        }
    }

    TestCase {
        name: "DialogTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(100);
            dialog1.open();
            wait(200);
            dialog1.close();

            wait(TestEnv.waitTime);
        }
    }

}
