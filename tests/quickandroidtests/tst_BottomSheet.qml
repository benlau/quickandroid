import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    width: 480
    height: 640


    BottomSheet {
        id: sheet1

        Column {
            width: parent.width
            height: childrenRect.height

            ListItem {
                title: "Item A"
            }

            ListItem {
                title: "Item B"
            }

            ListItem {
                title: "Item C"
            }
        }
    }


    TestCase {
        name: "BottomSheetTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);
            sheet1.open();
            wait(TestEnv.waitTime);
        }
    }


}
