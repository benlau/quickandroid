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
    property ListItemStyle style: ThemeManager.currentTheme.listItem

    property string iconSource : ""

    property string title: ""

    property string subtitle : ""

    property string value : ""

    property bool interactive : true

    property bool selected : false

    property size iconSourceSize : Qt.size(-1,-1)

    property alias icon : iconHolder.children

    property alias rightIcon : valueHolder.children

    property int dividerLeftInset : style.dividerLeftInset

    property int dividerRightInset : style.dividerRightInset

    property bool showDivider: style.showDivider

    signal clicked();

    property bool _iconSet : false

    color : component.style.backgroundColor

    implicitWidth: titleItem.x +
                   Math.max(titleMetrics.width,
                            subtitleMetrics.width) +
                   valueHolder.width +
                   component.style.rightPadding

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

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: component.interactive
        onClicked: component.clicked();

        Rectangle {
            id : mask
            anchors.fill: parent
            color : Constants.black12
            visible: mouseArea.pressed
        }
    }

    Item {
        id: iconHolder
        anchors {
            left: parent.left
            top : parent.top
            bottom : parent.bottom
            leftMargin : component.style.leftPadding
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
        material: component.style.title
        elide: Text.ElideRight
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: _iconSet ? component.style.titleKeyline : component.style.leftPadding
        anchors.topMargin: component.style.textTopPadding
        anchors.rightMargin: parent.width - valueHolder.x
    }

    Text {
        id : subtitleItem
        text: subtitle
        visible : subtitle !== ""
        material: component.style.subtitle
        elide: Text.ElideRight

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: _iconSet ? component.style.titleKeyline : component.style.leftPadding
        anchors.rightMargin: parent.width - valueHolder.x
        anchors.bottomMargin: component.style.textBottomPadding
    }

    Item {
        id: valueHolder
        anchors.right: parent.right
        anchors.rightMargin: component.style.rightPadding
        width: childrenRect.width
        height: parent.height

        Text {
           id: valueItem
           material: component.style.valueText
           text: value
           elide: Text.ElideRight

           anchors.top: parent.top
           anchors.bottom: parent.bottom
           anchors.topMargin: component.style.textTopPadding
         }
    }

    Loader {
        id : dividerLoader
        sourceComponent: component.style.divider
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

