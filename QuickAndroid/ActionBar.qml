import QtQuick 2.0
import QtQuick.Layouts 1.1
import "android.js" as A
import "res.js" as Res
import "global.js" as Global

Item {
    id: actionBar

    property bool showIcon : true

    property alias title : titleText.text

    property alias homeIcon : home.source

    property bool showTitle : true

    property alias menuBar : menuBarRegion.children

    property bool upEnabled : false

    property string icon

    property var style
    property alias _style : styleItem

    property alias content : fillArea.children

    property alias actionButtonEnabled : actionButton.enabled

    signal actionButtonClicked

    width : 480
    height: A.dp * 48

    anchors.top: parent.top
    anchors.topMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0
    anchors.left: parent.left
    anchors.leftMargin: 0

    Item {
        id : styleItem
        property string icon
        property string homeAsUpIndicator
        property string background
        property string actionButtonBackground
        property var titleTextStyle
        property var homeMarginLeft
        property var divider
        property var padding
    }

    Drawable {
        id : bg
        anchors.fill: parent
        source : _style.background
    }

    RowLayout {
        anchors.fill: parent
        spacing : 0

    QuickButton {
        id : actionButton
        objectName : "ActionButton"
        anchors.top : parent.top
        anchors.left: parent.left
        width : show ? Math.min(implicitWidth , menuBarRegion.x) : 0
        implicitWidth: titleText.x + (titleText.implicitWidth + 8 * A.dp) * showTitle
        height : 48 * A.dp
        background: _style.actionButtonBackground
        clip : true

        property bool show : upEnabled || showIcon || showTitle

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.maximumWidth: implicitWidth
        Layout.minimumWidth: titleText.x + 8 * A.dp

        Drawable {
            id : up
            anchors.verticalCenter: parent.verticalCenter
            source :  _style.homeAsUpIndicator
            width : showIcon ? implicitWidth : 0
            visible: upEnabled && showIcon
            asynchronous: true
        }

        Image {
            id : home
            width: showIcon && _style.icon || actionBar.icon ? height : 0
            height: 32 * A.dp
            anchors.left: up.right
            anchors.leftMargin: _style.homeMarginLeft * A.dp
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            source: actionBar.icon ? actionBar.icon : _style.icon
            sourceSize: Qt.size(32 * A.dp,32 * A.dp)
        }

        Text {
            id : titleText
            text: "Application Title"

            verticalAlignment: Text.AlignVCenter
            wrapMode : Text.NoWrap
            maximumLineCount:1
            visible : showTitle

            anchors.left: home.right
            anchors.leftMargin: 8 * A.dp
            anchors.verticalCenter: parent.verticalCenter
//            horizontalAlignment: paintedWidth < width ? Text.AlignHCenter : Text.AlignLeft
            horizontalAlignment : Text.AlignLeft

            color : _style.titleTextStyle.textColor.color
            font.pixelSize: _style.titleTextStyle.textSize * A.dp
        }

        onClicked: actionBar.actionButtonClicked();
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

    onStyleChanged: {
        Res.extend(_style,Res.Style.ActionBar);
        Res.extend(_style,style);
        _styleChanged();
    }

    Component.onCompleted: {
        if (!actionBar.icon &&
             Global.application &&
             Global.application.icon) {
            actionBar.icon = Global.application.icon
        }
        Res.extend(_style,Res.Style.ActionBar);
        Res.extend(_style,style);
        _styleChanged();
    }

}
