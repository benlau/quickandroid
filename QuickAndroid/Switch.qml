import QtQuick 2.0
import QuickAndroid 0.1

Item {
    id: component
    width: trackItem.width
    height: trackItem.height

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
        width: thumbItem.fillArea.width * 2
        height: _textHeight + thumbItem.fillArea.y +
                thumbItem.fillArea.bottomMargin + 8 * A.dp

        MouseArea {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width / 2
            onClicked: component.checked = false;
            z: -1
        }

        MouseArea {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width / 2
            onClicked: component.checked = true;
            z: -1
        }

        content: StateListDrawable {
            id: thumbItem
            source: _style.thumb
            anchors.verticalCenter: parent.verticalCenter
            x: -thumbItem.fillArea.x
            height: parent.height
            width: _textWidth + _style.thumbTextPadding * 2 * A.dp +
                   thumbItem.fillArea.x + thumbItem.fillArea.rightMargin
            checked: component.checked
            pressed: mouseArea.pressed

            content: Text {
                id: label
                text: _inLeft ? textOff : textOn
                font.pixelSize: _style.switchTextAppearance.textSize * A.dp
                color : _style.switchTextAppearance.textColor.color
                TextGravityBehaviour { gravity : "center" }
            }

            DrawableGravityBehaviour {
                gravity: "center"
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                drag.target: thumbItem
                drag.minimumX: -thumbItem.fillArea.x
                drag.maximumX: trackItem.fillArea.width - thumbItem.width + thumbItem.fillArea.x
            }
        }
    }

    Modifier {
        target: component ;
        property: "checked";
        when: mouseArea.drag.active;
        value: !_inLeft
    }

    /* Find out the best size for thumb item */
    property real _textWidth: Math.max(textOffItem.contentWidth,textOnItem.contentWidth)
    property real _textHeight: Math.max(textOffItem.contentHeight,textOnItem.contentHeight)

    Text {id: textOffItem;text: textOff;font.pixelSize: _style.switchTextAppearance.textSize * A.dp;visible: false;}
    Text {id: textOnItem; text: textOn; font.pixelSize: _style.switchTextAppearance.textSize * A.dp;visible: false;}

    function _updateStyle() {
        Res.copy(_style,Res.Style.Widget.CompoundButton.Switch);
        Res.copy(_style,style);
        _styleChanged();
    }

    Component.onCompleted: {
        _updateStyle();
    }
    onStyleChanged: _updateStyle();

    states: [
        State {
            when: mouseArea.drag.active
        },

        State {
            when: !component.checked && !mouseArea.drag.active
            PropertyChanges {
                target: thumbItem
                x: -thumbItem.fillArea.x
            }
        },
        State {
            when: component.checked && !mouseArea.drag.active
            PropertyChanges {
                target: thumbItem
                x: trackItem.fillArea.width - thumbItem.width + thumbItem.fillArea.x
            }
        }
    ]

    transitions: [
        Transition {
            from : "*"
            to: "*"
            PropertyAnimation {
                target: thumbItem
                property : "x"
                duration: Res.config.config_activityShortDur;
            }
        }

    ]

}
