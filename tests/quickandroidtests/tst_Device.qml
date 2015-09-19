import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : window
    width: 480
    height: 640

    TestCase {
        name: "DeviceTests"
        width : 480
        height : 480

        function test_preview() {

            // Default value
            compare(Device.dp,1);
            compare(Device.dpi,72);
        }
    }


}

