// A button with background
import QtQuick 2.0
import "res.js" as Res
import QuickAndroid 0.1

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

    property alias _style : styleItem
    property var style

    // Load background in asynchronous mode
    property bool asynchronous : false

    property string gravity : "center"

    Item {
        id : styleItem
        property var background
        property var textAppearance
    }

    StateListDrawable {
        id : drawableItem
        asynchronous: button.asynchronous
        anchors.fill: parent
        pressed: button.pressed
        source: button.background ? button.background : _style.background
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
                        color : _style.textAppearance.textColor.color
                        font.pixelSize: _style.textAppearance.textSize * A.dp
                        elide : Text.ElideLeft
                        maximumLineCount : 1
                        wrapMode: Text.WrapAnywhere

                        text: button.text
                    }
        }

        DrawableGrowBehaviour {
        }
    }

    onStyleChanged: {
        Res.extend(_style,Res.Style.Widget.Button)
        Res.extend(_style,style);
        _styleChanged();
    }

    Component.onCompleted: {
        Res.extend(_style,Res.Style.Widget.Button)
        Res.extend(_style,style);
        _styleChanged();
    }
}
