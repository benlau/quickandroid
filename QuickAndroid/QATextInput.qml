// Android style Text Input
import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.priv 0.1
import QuickAndroid.style 0.1

Item {
    id: component


    property alias text : textInputItem.text

    property alias textInput : textInputItem
    property alias flickable : flickableItem

    // The background of the text input
    property var background
    property alias gravity: gravityBehaviour.gravity


    property alias textSelectHandle: textSelectHandleItem

    property alias textSelectHandleRunning : textSelectHandlePopup.active

//  property TextInputStyle style : Style.theme.textInput

    property TextInputStyle style : TextInputStyle {
        background: Style.theme.textInput.background
//        textStyle: Style.theme.textInput.textStyle
        textStyle: TextStyle {
            textSize: Style.theme.textInput.textStyle.textSize
            textColor: Style.theme.textInput.textStyle.textColor
        }
        textSelectHandle: Style.theme.textInput.textSelectHandle
        property var dirtyHack : component.text
        // Dirty hack to ensure the "style" object is created before user use it
    }

    StateListDrawable {
        id : backgroundItem
        anchors.fill: parent

        source: component.background ? component.background : component.style.background

        selected: textInput.activeFocus
        fillArea.clip : true

        content: Flickable {
            id: flickableItem
            anchors.fill: parent
            anchors.leftMargin: 4 * A.dp
            anchors.rightMargin: 4 * A.dp
            implicitWidth: textInputItem.contentWidth
            implicitHeight: textInputItem.contentHeight
            contentWidth: textInputItem.contentWidth
            contentHeight: parent.height
            flickableDirection : Flickable.HorizontalFlick
            interactive: flickableItem.width < textInputItem.contentWidth

            TextInput {
                id : textInputItem
                focus: true
//                font.pixelSize: _style.textStyle.textSize * A.dp
//                color: _style.textStyle.textColor.color
                height: flickableItem.height

                // In nexus 5, the default keyboard with predictive text will modify the input value
                // when user is dragging the text select handle. No solution yet. Just disable it.
                inputMethodHints: Qt.ImhNoPredictiveText

                TextBehaviour {
                    id : gravityBehaviour
                    textStyle:  component.style.textStyle
                    gravity: "bottom"
                }
            }
        }
    }

    Item { // The ghost of cursor rectangle
        id : cursorRectangle
        property var rect : component.mapFromItem(textInputItem,
                                                        textInput.cursorRectangle.x,textInput.cursorRectangle.y,
                                                        textInput.cursorRectangle.width,textInput.cursorRectangle.height);                
        x: limit(rect.x,0,backgroundItem.fillArea.x + backgroundItem.fillArea.width)
        y: rect.y; width: rect.width;height: rect.height

        function limit(input , min ,max) {
            if (input < min)
                return min;
            if (input > max)
                return max;
            return input;
        }
    }


    Item {
        id: textSelectHandleItem
        anchors.top: cursorRectangle.bottom
        anchors.horizontalCenter: cursorRectangle.horizontalCenter
        width: textSelectHandleIcon.width
        height: textSelectHandleIcon.height

        PopupArea {
            id: textSelectHandlePopup
            anchors.fill: parent
        }
    }

    Overlay {
        id : overlay
        Ghost {
            id: textSelectHandleGhost
            target: textSelectHandleItem

            Drawable {
                id : textSelectHandleIcon
                asynchronous: true
                opacity: 0.0
                source: component.style.textSelectHandle
                anchors.centerIn: parent

                MouseArea {
                   anchors.fill: parent
                   enabled: textSelectHandleRunning
                   id : textSelectHandleMouseArea
                   drag.target: textSelectHandleItem
                   drag.axis: Drag.XAxis
                   drag.minimumX: backgroundItem.fillArea.x - textSelectHandleItem.width / 2
                   drag.maximumX: backgroundItem.fillArea.x + Math.min(backgroundItem.fillArea.width,
                                                                       textInputItem.contentWidth + cursorRectangle.width) - textSelectHandleItem.width / 2

                   states : [
                      State {
                          when: textSelectHandleMouseArea.pressed

                          AnchorChanges {
                              target: textSelectHandleItem
                              anchors.top : undefined
                              anchors.horizontalCenter: undefined
                          }
                      }
                   ]
                }
            }
        }
    }

    Modifier {
        // Let's cursor follow dragging textSelectHandle
        target: textInputItem
        property: "cursorPosition"
        when: !stepBack.running && !stepForward.running && textSelectHandleMouseArea.drag.active
        value :  textInputItem.positionAt(textInputItem.mapFromItem(component,
                                                                     textSelectHandleItem.x + textSelectHandleItem.width / 2,
                                                                     textSelectHandleItem.y).x ,0);
    }

    Timer {
        id: stepBack
        repeat: true
        interval : 100
        running: textSelectHandleRunning &&
                 textSelectHandleMouseArea.pressed &&
                 textSelectHandle.x === textSelectHandleMouseArea.drag.minimumX
        onTriggered: {
            if (textInput.cursorPosition !== 0)
                textInput.cursorPosition = textInput.cursorPosition - 1
        }
    }

    Timer {
        id: stepForward
        repeat: true
        interval : 100
        running: textSelectHandleRunning && textSelectHandleMouseArea.pressed &&
                 textSelectHandle.x === textSelectHandleMouseArea.drag.maximumX
        onTriggered: {
            if (textInput.cursorPosition !== textInput.length)
                textInput.cursorPosition = textInput.cursorPosition + 1
        }
    }

    AnimatedModifier {
        // Flick the content if cursor is not in range
        target: flickableItem

        property: "contentX"
        duration: 300

        value: textInput.cursorRectangle.x < flickableItem.contentX ?
            textInput.cursorRectangle.x :
            textInput.cursorRectangle.x + textInput.cursorRectangle.width

        when: textSelectHandleRunning &&
                 (textInput.cursorRectangle.x <  flickableItem.contentX ||
                 textInput.cursorRectangle.x >= flickableItem.contentX + backgroundItem.fillArea.width)
    }

    Binding { target: textSelectHandleEntryAnim.item; property : "target" ; value: textSelectHandleIcon ; when: true }
    Modifier { target: textSelectHandleEntryAnim.item; property : "running" ; value: textSelectHandleRunning ; when: true }

    Binding { target: textSelectHandleExitAnim.item;  property : "target" ; value: textSelectHandleIcon ; when: true }
    Modifier { target: textSelectHandleExitAnim.item;  property : "running" ; value: !textSelectHandleRunning; when: true }

    Modifier { target: component; property : "textSelectHandleRunning";
                when: flickableItem.dragging
                value: false}

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
            textInput.focus = true;
            mouse.accepted = false;
        }
    }
}
