/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Web: https://github.com/benlau/quickandroid
*/

import QtQuick 2.4
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

/*
  Reference:

  Lists: Controls - Components - Google design guidelines
  https://www.google.com/design/spec/components/lists-controls.html#
 */

Rectangle {
    id: component
    property ListItemMaterial material: ThemeManager.currentTheme.listItem

    property string iconSource : ""

    property string title: ""

    property string subtitle : ""

    property string value : ""

    property bool interactive : true

    property bool selected : false

    property size iconSourceSize : Qt.size(-1,-1)

    property alias icon : iconHolder.children

    property alias rightIcon : valueHolder.children

    property int dividerLeftInset : material.dividerLeftInset

    property int dividerRightInset : material.dividerRightInset

    property bool showDivider: material.showDivider

    signal clicked();

    property bool _iconSet : false

    color : component.material.backgroundColor

    implicitWidth: titleItem.x +
                   Math.max(titleMetrics.width,
                            subtitleMetrics.width) +
                   valueHolder.width +
                   component.material.rightPadding

    anchors {
        left: parent ? parent.left : undefined
        right: parent ? parent.right : undefined
    }

    Component {
        id : defaultIconComponent
        Image {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            source: component.iconSource
            sourceSize: component.iconSourceSize
        }
    }

    Ink {
        id: mouseArea
        anchors.fill: parent
        enabled: component.interactive
        onClicked: component.clicked();
    }

    Item {
        id: iconHolder
        anchors {
            left: parent.left
            top : parent.top
            bottom : parent.bottom
            leftMargin : component.material.leftPadding
        }

        Image {
            id: iconImage
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            source: component.iconSource
            sourceSize: component.iconSourceSize
        }
    }

    onIconChanged: _iconSet = true;
    onIconSourceChanged: _iconSet = true;

    Text {
        id: titleItem
        text: title
        material: component.material.title
        elide: Text.ElideRight
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: _iconSet ? component.material.titleKeyline : component.material.leftPadding
        anchors.topMargin: component.material.textTopPadding
        anchors.rightMargin: parent.width - valueHolder.x
    }

    Text {
        id : subtitleItem
        text: subtitle
        visible : subtitle !== ""
        material: component.material.subtitle
        elide: Text.ElideRight

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: _iconSet ? component.material.titleKeyline : component.material.leftPadding
        anchors.rightMargin: parent.width - valueHolder.x
        anchors.bottomMargin: component.material.textBottomPadding
    }

    Item {
        id: valueHolder
        anchors.right: parent.right
        anchors.rightMargin: component.material.rightPadding
        width: childrenRect.width
        height: parent.height

        Text {
           id: valueItem
           material: component.material.valueText
           text: value
           elide: Text.ElideRight

           anchors.top: parent.top
           anchors.bottom: parent.bottom
           anchors.topMargin: component.material.textTopPadding
         }
    }

    Loader {
        id : dividerLoader
        sourceComponent: component.material.divider
        visible: showDivider

        anchors {
            left: parent.left
            leftMargin: dividerLeftInset
            right: parent.right
            bottom: parent.bottom
            rightMargin: dividerRightInset
        }
    }

    TextMetrics {
        id: titleMetrics
        font: titleItem.font
        text: title
    }

    TextMetrics {
        id: subtitleMetrics
        font: subtitleItem.font
        text: subtitle
    }

}

