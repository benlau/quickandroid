/*
   License: Apache License
   Author : @benlau
   Project: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import "./priv"

Item {
    id: component

    property color backgroundColor: Style.theme.colorPrimary
    property color indicatorColor: "#fff59d"
    property color textColor : "#ffffff"

    property ListModel tabs : ListModel {}
    property int count : tabs.count
    property int currentIndex: 0

    height: _textAndIcon ? 72 * A.dp : 48 * A.dp

    property bool _textAndIcon: false
    property int _itemWidth: component.width / component.count

    Rectangle {
        anchors.fill: parent
        color: component.backgroundColor        
    }

    Row {
        anchors.fill: parent

        Repeater {
            id: repeater

            model: component.tabs
            delegate: Tab {
                title: model.title ? model.title : ""
                iconSource: model.iconSource ? model.iconSource : ""
                width: component._itemWidth
                height: component.height
                active: currentIndex === model.index

                onClicked: {
                    component.currentIndex = model.index;
                }

                Component.onCompleted: {
                    if (model.title && model.iconSource)
                        component._textAndIcon = true;
                }
            }
        }
    }

    Rectangle {
        id: indicator
        height: 2 * A.dp
        width: _itemWidth
        color: indicatorColor
        anchors.bottom: parent.bottom
        x: currentIndex * component._itemWidth

        Behavior on x {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }

    }

}

