import QtQuick 2.0
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import "global.js" as Global

Item {
    id: actionBar

    property bool showIcon : true

    property alias title : titleText.text

    property alias homeIcon : home.source

    property bool showTitle : true

    property alias menuBar : menuBarRegion.children

    property bool upEnabled : false

    property string iconSource

    property ActionBarStyle style : ActionBarStyle {
        iconSource : Style.theme.actionBar.iconSource
        background: Style.theme.actionBar.background
        actionButtonBackground: Style.theme.actionBar.actionButtonBackground
        titleTextStyle:  Style.theme.actionBar.titleTextStyle
        homeAsUpIndicator: Style.theme.actionBar.homeAsUpIndicator
        homeMarginLeft: Style.theme.actionBar.homeMarginLeft
        divider: Style.theme.actionBar.divider
        padding: Style.theme.actionBar.padding
    }

    property alias content : fillArea.children

    property alias actionButtonEnabled : actionButton.enabled

    signal actionButtonClicked

    width : 480
    height: A.dp * 48

    Drawable {
        id : bg
        anchors.fill: parent
        source: actionBar.style.background
    }

    RowLayout {
        anchors.fill: parent
        spacing : 0

    QuickButton {
        id : actionButton
        objectName : "ActionButton"
        width : show ? Math.min(implicitWidth , menuBarRegion.x) : 0
        implicitWidth: titleText.x + (titleText.implicitWidth + 8 * A.dp) * showTitle
        height : actionBar.height
        background: actionBar.style.actionButtonBackground
        clip : true

        property bool show : upEnabled || showIcon || showTitle

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.maximumWidth: implicitWidth
        Layout.minimumWidth: titleText.x + 8 * A.dp

        Drawable {
            id : up
            anchors.verticalCenter: parent.verticalCenter
            source :  actionBar.style.homeAsUpIndicator
            width : showIcon ? implicitWidth : 0
            visible: upEnabled && showIcon
            asynchronous: true
        }

        Image {
            id : home
            width: show ? height : 0
            height: 32 * A.dp
            x: Math.max(actionBar.style.keyline1 * A.dp,up.x + up.width)
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            source: actionBar.iconSource ? actionBar.iconSource : actionBar.style.iconSource
            sourceSize: Qt.size(32 * A.dp,32 * A.dp)

            property bool show: showIcon && actionBar.style.iconSource || actionBar.iconSource
        }

        Text {
            id : titleText
            text: "Application Title"

            property int keyline: (home.show ? actionBar.style.keyline2 : actionBar.style.keyline1 ) * A.dp

            x: keyline
            verticalAlignment: Text.AlignVCenter
            wrapMode : Text.NoWrap
            maximumLineCount:1
            elide: Text.ElideRight
            visible: showTitle
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment : Text.AlignLeft

            color : actionBar.style.titleTextStyle.textColor
            font.pixelSize: actionBar.style.titleTextStyle.textSize * A.dp
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

    Component.onCompleted: {
        if (!actionBar.icon &&
             Global.application &&
             Global.application.iconSource) {
            actionBar.iconSource = Global.application.iconSource
        }

    }

}
