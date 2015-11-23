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

    Dialog {
        id: dialog2
        Text {
            objectName: "MessageText"
            text: "Message"
        }
    }

    Ruler {
        id: dialog1ButtonSection
        parent: Testable.search(dialog1,"DialogButtonSection");
        orientation: Qt.Vertical
        anchors.fill: parent
    }

    Ruler {
        parent: Testable.search(dialog1,"DialogButtonSection");
        orientation: Qt.Vertical
        width: 20
        height: 8
        x: 250
        y: 52 - 8
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

            compare(dialog1.rejectButton.x +
                    dialog1.rejectButton.width + 8,
                    dialog1.acceptButton.x);

            dialog1.close();

            wait(TestEnv.waitTime);
        }

        function test_without_title_buttons() {
            wait(100);
            dialog2.open();
            wait(200);

            var content = Testable.search(dialog2,"ContentSection");
            compare(content.y,24);

            wait(TestEnv.waitTime);
        }
    }

}
