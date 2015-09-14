import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.drawable 0.1
import QuickAndroid.Styles 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Drawable {
        id : background
        anchors.fill: parent
        source : "drawable/BackgroundHoloLight.qml"
    }

    Column {
        anchors.fill: parent

        Drawable {
            id : itemBackground
            source : "drawable/ItemBackgroundHoloLight.qml"
            width : parent.width
            height : A.px(48)

            Drawable {
                id : up
                anchors.verticalCenter: parent.verticalCenter
                source : "drawable-xxhdpi/ic_ab_back_holo_light_am.png"
            }
        }

        // A drawable that set source to a component
        Drawable {
            id : drawable3
            source: Rectangle {
                implicitWidth: 100
                implicitHeight: 100
                color : "#ffffff"
            }

            content : Text {
                    anchors.centerIn: parent
                    text: "Drawable3"
                    color : Constants.black87
                    horizontalAlignment: Text.Center
            }
        }

        Drawable {
            id: drawable4
            source: Component {
                Rectangle {
                    color: "red"
                }
            }
            width: parent.width
            height: A.px(48)
        }

    }

    TestCase {
        name: "DrawableTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
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

            compare(drawable4.item,drawable4.canvas);
            compare(String(drawable4.item).indexOf("QQuickRectangle") === 0,true);

            wait(TestEnv.waitTime);
//            wait(60000);
        }
    }

}
