// Android style Text Input
import QtQuick 2.0
import QuickAndroid 0.1

Item {
    id: component

    property alias text : textInputItem.text

    property alias textInput : textInputItem
    property alias flickable : flickableItem

    // The background of the text input
    property var background
    property alias gravity: gravityBehaviour.gravity
    property var style : ({})
    property alias _style : styleItem

    Item {
        id : styleItem
        property string background
        property var textStyle
    }

    StateListDrawable {
        id : backgroundItem
        anchors.fill: parent

        source: component.background ? component.background : _style.background

        DrawableGravityBehaviour {
            id : gravityBehaviour
            gravity: "down"
        }

        content: Flickable {
            id: flickableItem
            implicitWidth: textInputItem.implicitWidth
            implicitHeight: textInputItem.implicitHeight
            contentWidth: textInputItem.implicitWidth
            contentHeight: textInputItem.implicitHeight
            clip: true
            flickableDirection : Flickable.HorizontalFlick

            TextInput {
                id : textInputItem
                font.pixelSize: _style.textStyle.textSize * A.dp
                color: _style.textStyle.textColor.color
            }
        }
    }

    function _updateStyle() {
        Res.copy(_style,Res.Style.Widget.TextInput);
        Res.copy(_style,style);
        _styleChanged();
    }

    Component.onCompleted: _updateStyle();
    onStyleChanged: _updateStyle();
}
