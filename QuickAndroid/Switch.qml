import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.priv 0.1
import QuickAndroid.style 0.1

Item {
    id: component
    implicitWidth: trackItem.width
    implicitHeight: trackItem.height

    property bool checked : false
    property string textOn : qsTr("ON")
    property string textOff : qsTr("OFF")

    property SwitchStyle style : Style.theme.switchStyle

    property bool _inLeft: (thumbItem.x + thumbItem.fillArea.x) <
                           (trackItem.fillArea.width - thumbItem.fillArea.width) / 2

    StateListDrawable {
        id : trackItem
        anchors.verticalCenter: parent.verticalCenter
        enabled: component.enabled
        source: component.style.track
        width: _trackWidth
        height: _thumbHeight

        MouseArea {
            anchors.fill: parent
            onClicked: {
                component.checked = !component.checked;
            }
            z: -100;
        }

        content: StateListDrawable {
            id: thumbItem
            source: component.style.thumb
            anchors.verticalCenter: parent.verticalCenter
            height: _thumbHeight
            width: _thumbWidth
            checked: component.checked
            pressed: mouseArea.pressed

            content: Text {
                id: label
                text: _inLeft ? textOff : textOn
                font.pixelSize: component.style.textStyle.textSize * A.dp
                color : component.style.textStyle.textColor
                TextBehaviour { gravity : "center" }
            }

            DrawableGravityBehaviour {
                gravity: "center"
            }

            MouseArea {
                id: mouseArea
                anchors.fill: thumbItem.fillArea
                drag.target: thumbItem
                drag.minimumX: -thumbItem.fillArea.x
                drag.maximumX: trackItem.fillArea.width - thumbItem.width + thumbItem.fillArea.x

                onReleased: {
                    component.checked = !_inLeft
                }
            }
        }
    }

    /*
    Modifier {
        target: component ;
        property: "checked";
        when: mouseArea.drag.active;
        value: !_inLeft
    }
    */

    /* Load a set of dummy components for calculate the dimen of other visible component.
       It could avoid "Binding loop detected" warning
     */
    property real _textWidth: Math.max(textOffItem.contentWidth,textOnItem.contentWidth)
    property real _textHeight: Math.max(textOffItem.contentHeight,textOnItem.contentHeight)
    property real _thumbMinWidth:  _textWidth + component.style.thumbTextPadding * 2 * A.dp
    property real _thumbWidth: _thumbMinWidth + thumbDummy.fillArea.x + thumbDummy.fillArea.rightMargin
    property real _thumbHeight: _textHeight + 8 * A.dp + thumbDummy.fillArea.y + thumbDummy.fillArea.bottomMargin
    property real _trackWidth : _thumbMinWidth * 2
    Text {id: textOffItem;text: textOff;font.pixelSize: component.style.textStyle.textSize * A.dp;visible: false;}
    Text {id: textOnItem; text: textOn; font.pixelSize: component.style.textStyle.textSize * A.dp;visible: false;}
    Drawable{id: thumbDummy ;source: component.style.thumb;visible: false}


    AnimatedModifier {
        target: thumbItem
        property: "x"
        value: -thumbItem.fillArea.x
        when: !component.checked && !mouseArea.pressed
    }

    AnimatedModifier {
        target: thumbItem
        property: "x"
        value: trackItem.fillArea.width - thumbItem.width + thumbItem.fillArea.x
        when: component.checked && !mouseArea.pressed
    }
}
