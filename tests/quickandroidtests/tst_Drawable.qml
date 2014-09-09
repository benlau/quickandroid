import QtQuick 2.0
import QtTest 1.0
import "../.."
import "../../res.js" as Res

Rectangle {
    id : rect
    width: 480
    height: 640

    Drawable {
        id : background
        anchors.fill: parent
        source : "drawable/BackgroundHoloLight.qml"
    }

    Drawable {
        id : itemBackground
        source : "drawable/ItemBackgroundHoloLight.qml"
        width : parent.width
        height : 48

        Drawable {
            id : up
            anchors.verticalCenter: parent.verticalCenter
            source : "drawable-xxhdpi/ic_ab_back_holo_light_am.png"
        }
    }

    // A drawable that set source to a component
    Drawable {
        id : drawable3
        anchors.top : itemBackground.bottom
        source: Rectangle {
            implicitWidth: 100
            implicitHeight: 100
            color : "#ffffff"
        }

        content : Text {
                anchors.centerIn: parent
                text: "Drawable3"
                color : Res.Style.Black87
                horizontalAlignment: Text.Center
        }
    }

    TestCase {
        name: "DrawableTests"
        width : 480
        height : 480
        when : windowShown

        function test_basic() {
            compare(Image.Ready , Loader.Ready)           
            compare(background.status , Loader.Ready);

            compare(up.dp,3);
            compare(up.implicitWidth,16);
            compare(up.status , Image.Ready);

            compare(background.width,background.fillArea.width);
            compare(background.height,background.fillArea.height);

            compare(drawable3.fillArea.x,0);
            compare(drawable3.fillArea.y,0);
            compare(drawable3.fillArea.width,100);
            compare(drawable3.fillArea.height,100);

//            wait(60000);
        }
    }

}
