import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.drawable 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        y: 10

        Switch {
            x: 100
            width: 100
            height: 48
        }

    }

    TestCase {
        name: "SwitchTests"
        width : 480
        height : 480
        when : windowShown

        function test_basic() {
            wait(60000);
        }
    }

}
