// A button with background
import QtQuick 2.0
import "res.js" as Res
import "android.js" as A

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

                    states: [State {
                        name: "left"
                        when: button.gravity === "left"

                            AnchorChanges {
                                target: item
                                anchors.left: item.parent.left
                                anchors.verticalCenter: item.parent.verticalCenter
                            }
                        },State {
                            name: "right"
                            when: button.gravity === "right"

                            AnchorChanges {
                                target: item
                                anchors.right: item.parent.right
                                anchors.verticalCenter: item.parent.verticalCenter
                            }
                        },State {
                            name: "top"
                            when: button.gravity === "top"

                            AnchorChanges {
                                target: item
                                anchors.horizontalCenter: item.parent.horizontalCenter
                                anchors.top: item.parent.top
                            }
                        },State {
                            name: "bottom"
                            when: button.gravity === "bottom"

                            AnchorChanges {
                                target: item
                                anchors.horizontalCenter: item.parent.horizontalCenter
                                anchors.bottom: item.parent.bottom
                            }
                        },State {
                            name : "center"
                            when : button.gravity === "center"
                            AnchorChanges {
                                target: item
                                anchors.horizontalCenter: item.parent.horizontalCenter
                                anchors.verticalCenter: item.parent.verticalCenter
                            }
                        }

                    ]

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
