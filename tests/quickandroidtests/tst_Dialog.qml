import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Activity {
    id : rect
    width: 480
    height: 640

    MouseArea {
        anchors.centerIn: parent
        width: 100
        height: 100
        onClicked : {
            dialog1.active = !dialog1.active;
        }

        Text {
            anchors.centerIn: parent
            text: "Click here top launch dialog"
        }
    }

    Dialog {
        id: dialog1
        anchors.centerIn: parent
        width : parent.width * 0.8
        height: width
//        active: true

        source: "#ffffff"

        MaterialShadow {
            anchors.fill: dialog1
            asynchronous: true
            depth: 3
            z: -100
            visible: dialog1.opacity == 1
        }
    }

    TestCase {
        name: "DialogTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(TestEnv.waitTime);
        }
    }

}
