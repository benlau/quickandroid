import QtQuick 2.0
import QtTest 1.0
import "../../item"
import "../.."

Rectangle {
    id : rect
    width: 480
    height: 640

    ListModel {
        id : listModel

        ListElement {
            name : "Apple"
        }

        ListElement {
            name : "Banana"
        }

        ListElement {
            name : "Cinnamon"
        }

    }

    DropDownList {
        x: 0
        y : 0
        model : listModel
    }

    TestCase {
        name: "DropDownListTests"
        width : 480
        height : 480
        when : windowShown

        function test_basic() {
            // For initialization
//            wait(60000);

        }
    }


}
