import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    width: 480
    height: 640
    color : "gray"

    Drawable {
        id : menuDropDown
        source : Qt.resolvedUrl("./drawable/MenuDropdownPanelHoloLight.qml")
    }

    Rectangle {
        color : "#1F000000"
        anchors.fill: menuDropDown
    }

    TestCase {
        name: "NinePatchTests"
        when : windowShown

        function test_basic() {
            console.log(menuDropDown.implicitWidth,menuDropDown.implicitHeight);

            // Scaled to DP = 1
            compare(menuDropDown.implicitWidth,64);
            compare(menuDropDown.implicitHeight,32);
            compare(menuDropDown.fillArea.x,8);
            compare(menuDropDown.fillArea.y,8);
            compare(menuDropDown.fillArea.width,48);
            compare(menuDropDown.fillArea.height,16);
        }
    }

}
