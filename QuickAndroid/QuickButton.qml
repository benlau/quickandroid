// A button with background
import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1

MouseArea {
    id : button

    implicitWidth: drawable.implicitWidth
    implicitHeight: drawable.implicitHeight

    property var background
    property alias drawable : drawableItem
    property alias fillArea : drawableItem.fillArea
    property alias content : drawableItem.content

    property alias selected : drawableItem.selected

    property var icon
    property string text

//    property ButtonStyle style : Style.theme.button
    property ButtonStyle style : ButtonStyle {
        background : Style.theme.button.background
        textStyle: Style.theme.button.textStyle
    }
    // Load background in asynchronous mode
    property bool asynchronous : false

    property string gravity : "center"

    StateListDrawable {
        id : drawableItem
        asynchronous: button.asynchronous
        anchors.fill: parent
        pressed: button.pressed
        source: button.background ? button.background : button.style.background
        z: -1

        DrawableGravityBehaviour {
            gravity: button.gravity
        }

        content : Item {
                    id: item
                    width: childrenRect.width
                    height: childrenRect.height

                    Drawable {
                        id : iconDrawable
                        asynchronous: button.asynchronous
                        source: button.icon
                    }

                    Text {
                        width: text ? undefined : 0
                        height: text ? undefined : 0

                        verticalAlignment: Text.AlignVCenter
                        color : button.style.textStyle.textColor
                        font.pixelSize: button.style.textStyle.textSize * A.dp
                        elide : Text.ElideLeft
                        maximumLineCount : 1
                        wrapMode: Text.WrapAnywhere

                        text: button.text
                    }
        }

        DrawableGrowBehaviour {
        }
    }

}
