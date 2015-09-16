/*
   License: Apache License
   Author : @benlau
   Project: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./priv"

Item {
    id: component

    property TabBarStyle style: ThemeManager.currentTheme.tabBar

    property color backgroundColor: style.backgroundColor
    property color indicatorColor: style.indicatorColor

    property color textColor : style.textColor

    property var tabs : []

    property int count : tabs.length
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
                title: modelData.title ? modelData.title : ""
                iconSource: modelData.iconSource ? modelData.iconSource : ""
                width: component._itemWidth
                height: component.height
                active: currentIndex === index
                tintColor: component.textColor

                onClicked: {
                    component.currentIndex = index;
                }

                Component.onCompleted: {
                    if (title !=="" && iconSource !=="")
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
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }

    }

}

