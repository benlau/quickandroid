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

    property alias textSelectHandle: textSelectHandleItem
    property alias _style : styleItem

    property bool textSelectHandleRunning : false

    Item {
        id : styleItem
        property string background
        property var textStyle
        property var textSelectHandle
    }

    StateListDrawable {
        id : backgroundItem
        anchors.fill: parent

        source: component.background ? component.background : _style.background

        fillArea.clip : true

        content: Flickable {
            id: flickableItem
            anchors.fill: parent
            implicitWidth: textInputItem.contentWidth
            implicitHeight: textInputItem.contentHeight
            contentWidth: textInputItem.contentWidth
            contentHeight: textInputItem.contentHeight
            flickableDirection : Flickable.HorizontalFlick

            TextInput {
                id : textInputItem
                focus: true
                font.pixelSize: _style.textStyle.textSize * A.dp
                color: _style.textStyle.textColor.color

                onActiveFocusChanged: {
                    if (!activeFocus)
                        textSelectHandleRunning = false;
                }

                TextGravityBehaviour {
                    id : gravityBehaviour
                    gravity: "down"
                }

            }

            onFlickingChanged: {
                if (flicking)
                    component.textSelectHandleRunning = false;
            }
        }
    }

    Item { // The cursor rectangle mapped
        id : cursorRectangle
        property var rect : component.mapFromItem(textInputItem,
                                                        textInput.cursorRectangle.x,textInput.cursorRectangle.y,
                                                        textInput.cursorRectangle.width,textInput.cursorRectangle.height);
        x: rect.x;y : rect.y; width: rect.width;height: rect.height
    }

    Drawable {
        id: textSelectHandleItem
        parent: component
        opacity: 0.0
        source: _style.textSelectHandle

        anchors.top: cursorRectangle.bottom
        anchors.horizontalCenter: cursorRectangle.horizontalCenter

        MouseArea {
           anchors.fill: parent
           enabled: textSelectHandleRunning
           id : textSelectHandleMouseArea
           drag.target: textSelectHandleItem
           drag.axis: Drag.XAxis
           drag.minimumX: backgroundItem.fillArea.x - textSelectHandleItem.width / 2
           drag.maximumX: backgroundItem.fillArea.x + backgroundItem.fillArea.width - textSelectHandleItem.width / 2
        }

        states : [
           State {
               when: textSelectHandleMouseArea.drag.active

               AnchorChanges {
                   target: textSelectHandleItem
                   anchors.top : undefined
                   anchors.horizontalCenter: undefined
               }
           }
        ]
    }

    // Move cursorPosition on dragging
    Item { // It don't use Binding as it will restore the value
        enabled : !stepBack.running && !stepForward.running && textSelectHandleMouseArea.drag.active
        property int value :  textInputItem.positionAt(textInputItem.mapFromItem(component,
                                                                                 textSelectHandleItem.x + textSelectHandleItem.width / 2,
                                                                                 textSelectHandleItem.y).x ,0);
        onValueChanged: {
            if (!enabled)
                return;
            textInputItem.cursorPosition = value;
        }
    }

    Timer {
        id: stepBack
        repeat: true
        interval : 100
        running: textSelectHandleRunning && textSelectHandle.x === textSelectHandleMouseArea.drag.minimumX
        onTriggered: {
            if (textInput.cursorPosition !== 0)
                textInput.cursorPosition = textInput.cursorPosition - 1
        }
    }

    Timer {
        id: stepForward
        repeat: true
        interval : 100
        running: textSelectHandleRunning && textSelectHandle.x === textSelectHandleMouseArea.drag.maximumX
        onTriggered: {
            if (textInput.cursorPosition !== textInput.length - 1)
                textInput.cursorPosition = textInput.cursorPosition + 1
        }
    }

    PropertyAnimation {
        id : cursorVisibleAnimation
        target: flickableItem

        property: "contentX"
        duration: 300
        from: flickableItem.contentX
        to: textInput.cursorRectangle.x < flickableItem.contentX ?
            textInput.cursorRectangle.x :
            textInput.cursorRectangle.x + textInput.cursorRectangle.width

        running: textSelectHandleRunning &&
                 (textInput.cursorRectangle.x <  flickableItem.contentX ||
                 textInput.cursorRectangle.x >= flickableItem.contentX + backgroundItem.fillArea.width)
    }

    Binding { target: textSelectHandleEntryAnim.item; property : "target" ; value: textSelectHandleItem ; when: true }
    Binding { target: textSelectHandleEntryAnim.item; property : "running" ; value: true ; when: textSelectHandleRunning }
    Binding { target: textSelectHandleEntryAnim.item; property : "running" ; value: false ; when: !textSelectHandleRunning}

    Binding { target: textSelectHandleExitAnim.item;  property : "target" ; value: textSelectHandleItem ; when: true }
    Binding { target: textSelectHandleExitAnim.item;  property : "running" ; value: true; when: !textSelectHandleRunning }
    Binding { target: textSelectHandleExitAnim.item;  property : "running" ; value: false; when: textSelectHandleRunning}

    Loader {
        id : textSelectHandleEntryAnim
        asynchronous: true
        source : Res.Style.Animation.TextInput.textSelectHandleEnter
    }

    Loader {
        id : textSelectHandleExitAnim
        asynchronous: true
        source : Res.Style.Animation.TextInput.textSelectHandleExit
    }


    MouseArea {
        anchors.fill : parent
        propagateComposedEvents: true
        onPressed: {
            textSelectHandleRunning = true;
            mouse.accepted = false;
        }
    }

    function _updateStyle() {
        Res.copy(_style,Res.Style.Widget.TextInput);
        Res.copy(_style,style);
        _styleChanged();
    }

    Component.onCompleted: {
        _updateStyle();
        if (textInput.activeFocus)
            component.textSelectHandleRunning = textInput.activeFocus;
    }
    onStyleChanged: _updateStyle();
}
