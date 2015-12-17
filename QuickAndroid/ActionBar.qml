/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Web: https://github.com/benlau/quickandroid
*/

import QtQuick 2.4
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "global.js" as Global

/*!
   \qmltype ActionBar
   \inqmlmodule QuickAndrid 0.1
   \brief Action Bar Component
 */

Item {
    id: actionBar

    property bool showIcon : true

    property alias title : titleText.text

    property bool showTitle : true

    property alias menuBar : menuBarRegion.children

    property bool upEnabled : false

    property string iconSource : material.iconSource

    property size iconSourceSize : material.iconSourceSize

    /*!
      \qmlproperty Component background

      This property holds the component to use as the background.
     */
    property Component background : material.background

    /*!
      This property holds the color used to fill the action bar.
     */

    property color backgroundColor : material.backgroundColor

    property ActionBarMaterial material: ThemeManager.currentTheme.actionBar

    property alias content : fillArea.children

    property alias actionButtonEnabled : actionButton.enabled

    signal actionButtonClicked

    implicitHeight: material.unitHeight

    objectName: "ActionBar"

    Loader {
        property var control : actionBar
        anchors.fill: parent
        sourceComponent: actionBar.background
    }

    RowLayout {
        width: parent.width
        height: material.unitHeight
        spacing : 0

        Button {
            id : actionButton
            objectName : "ActionButton"
            implicitWidth: actionBar.iconSource !== "" && showIcon ? Math.max(48 * A.dp, iconItem.width + 32 * A.dp) : 0
            height : actionBar.height
            background: actionBar.material.actionButtonBackground
            clip : true

            property bool show : showIcon

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: implicitWidth
            Layout.minimumWidth: implicitWidth

            onClicked: actionBar.actionButtonClicked();

            Image {
                id: iconItem
                x: actionBar.material.keyline1

                anchors.verticalCenter: parent.verticalCenter
                source: actionBar.iconSource
                sourceSize: actionBar.iconSourceSize
            }
        }

        Item {
            id: spacer;
            Layout.maximumWidth: implicitWidth
            Layout.minimumWidth: implicitWidth
            implicitWidth: actionButton.width == 0 ? actionBar.material.keyline1 : Math.max(actionBar.material.keyline2 - actionButton.width , 0);
        }

        Text {
            id : titleText
            objectName: "ActionBarTitleTextItem"
            Layout.fillHeight: true
            Layout.fillWidth: true

            verticalAlignment: Text.AlignVCenter
            wrapMode : Text.NoWrap
            maximumLineCount:1
            elide: Text.ElideRight
            visible: showTitle
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment : Text.AlignLeft

            material: actionBar.material.title
        }

        Item {
            id : fillArea
            implicitWidth: childrenRect.width
            implicitHeight: childrenRect.height
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: children.length > 0 ? true : false
            Layout.fillHeight: true
            Layout.minimumWidth: 0
            Layout.minimumHeight: 0
        }

        Item {
            // The area reserved for menuBar.
            id : menuBarRegion
            implicitWidth: childrenRect.width
            implicitHeight: childrenRect.height
            Layout.minimumWidth: implicitWidth
            Layout.alignment: Qt.AlignRight
            Layout.fillWidth: false
        }

    } // End of RowLayout

    Component.onCompleted: {
        if (!actionBar.icon &&
             Global.application &&
             Global.application.iconSource) {
            actionBar.iconSource = Global.application.iconSource
        }

    }

}
