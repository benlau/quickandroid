import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.priv 0.1

Item {
    id: component
    implicitWidth: trackItem.width
    implicitHeight: trackItem.height

    property bool checked : false
    property string textOn : qsTr("ON")
    property string textOff : qsTr("OFF")

    property var style : ({})

    property alias _style : _styleItem

    property bool _inLeft: (thumbItem.x + thumbItem.fillArea.x) <
                           (trackItem.fillArea.width - thumbItem.fillArea.width) / 2

    Item {
        id: _styleItem
        property var track
        property var thumb
        property var switchTextAppearance
        property int thumbTextPadding
        property int switchMinWidth
        property int switchPadding
    }

    StateListDrawable {
        id : trackItem
        anchors.verticalCenter: parent.verticalCenter
        enabled: component.enabled
        source: _style.track
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
            source: _style.thumb
            anchors.verticalCenter: parent.verticalCenter
            height: _thumbHeight
            width: _thumbWidth
            checked: component.checked
            pressed: mouseArea.pressed

            content: Text {
                id: label
                text: _inLeft ? textOff : textOn
                font.pixelSize: _style.switchTextAppearance.textSize * A.dp
                color : _style.switchTextAppearance.textColor.color
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
    property real _thumbMinWidth:  _textWidth + _style.thumbTextPadding * 2 * A.dp
    property real _thumbWidth: _thumbMinWidth + thumbDummy.fillArea.x + thumbDummy.fillArea.rightMargin
    property real _thumbHeight: _textHeight + 8 * A.dp + thumbDummy.fillArea.y + thumbDummy.fillArea.bottomMargin
    property real _trackWidth : _thumbMinWidth * 2
    Text {id: textOffItem;text: textOff;font.pixelSize: _style.switchTextAppearance.textSize * A.dp;visible: false;}
    Text {id: textOnItem; text: textOn; font.pixelSize: _style.switchTextAppearance.textSize * A.dp;visible: false;}
    Drawable{id: thumbDummy ;source: _style.thumb;visible: false}


    function _updateStyle() {
        Res.copy(_style,Res.Style.Widget.CompoundButton.Switch);
        Res.copy(_style,style);
        _styleChanged();
    }

    Component.onCompleted: {
        _updateStyle();
    }

    onStyleChanged: _updateStyle();

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
