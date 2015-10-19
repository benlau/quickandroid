import QtQuick 2.4
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "global.js" as Global

Item {
    id: actionBar

    property bool showIcon : true

    property alias title : titleText.text

//    property alias homeIcon : home.source

    property bool showTitle : true

    property alias menuBar : menuBarRegion.children

    property bool upEnabled : false

    property string iconSource : style.iconSource

    property size iconSourceSize : style.iconSourceSize

    property var background : style.background

    property ActionBarStyle style: ThemeManager.currentTheme.actionBar

    property alias content : fillArea.children

    property alias actionButtonEnabled : actionButton.enabled

    signal actionButtonClicked

    implicitHeight: style.unitHeight

    Drawable {
        id : bg
        anchors.fill: parent
        source: actionBar.background
    }

    RowLayout {
        width: parent.width
        height: style.unitHeight
        spacing : 0

        /*
        Drawable {
            id : up
            anchors.verticalCenter: parent.verticalCenter
            source :  actionBar.style.homeAsUpIndicator
            width : showIcon ? implicitWidth : 0
            visible: upEnabled && showIcon
            asynchronous: true
        }
        */

        Button {
            id : actionButton
            objectName : "ActionButton"
            implicitWidth: actionBar.iconSource !== "" && showIcon ? Math.max(48 * A.dp, iconItem.width + 32 * A.dp) : 0
            height : actionBar.height
            background: actionBar.style.actionButtonBackground
            clip : true

            property bool show : showIcon

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: implicitWidth
            Layout.minimumWidth: implicitWidth

            onClicked: actionBar.actionButtonClicked();

            Image {
                id: iconItem
                x: actionBar.style.keyline1

                anchors.verticalCenter: parent.verticalCenter
                source: actionBar.iconSource
                sourceSize: actionBar.iconSourceSize
            }
        }

        Item {
            id: spacer;
            Layout.maximumWidth: implicitWidth
            Layout.minimumWidth: implicitWidth
            implicitWidth: actionButton.width == 0 ? actionBar.style.keyline1 : Math.max(actionBar.style.keyline2 - actionButton.width , 0);
        }

        Text {
            id : titleText
            Layout.fillHeight: true
            Layout.fillWidth: true

            verticalAlignment: Text.AlignVCenter
            wrapMode : Text.NoWrap
            maximumLineCount:1
            elide: Text.ElideRight
            visible: showTitle
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment : Text.AlignLeft

            text: actionBar.style.title
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
