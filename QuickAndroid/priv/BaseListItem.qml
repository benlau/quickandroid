import QtQuick 2.0
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1

/*
  Reference:

  Lists: Controls - Components - Google design guidelines
  https://www.google.com/design/spec/components/lists-controls.html#
 */

Rectangle {
    id: component
    property ListItemStyle style: Style.theme.listItem

    property string title: ""
    property string value : ""
    property string subtitle : ""

    property bool interactive : true
    property bool selected : false

    property string iconSource : ""
    property size iconSourceSize : Qt.size(-1,-1)

    property alias icon : iconHolder.children

    property alias rightIcon : valueHolder.children

    property int dividerLeftInset : style.dividerLeftInset
    property int dividerRightInset : style.dividerRightInset

    signal clicked();

    property bool _iconSet : false

    color : component.style.backgroundColor

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
            leftMargin : component.style.leftPadding * A.dp
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
        textStyle: component.style.titleTextStyle
        elide: Text.ElideRight
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: _iconSet ? component.style.titleKeyline * A.dp : component.style.leftPadding * A.dp
        anchors.topMargin: component.style.textTopPadding * A.dp
        anchors.rightMargin: parent.width - valueHolder.x
    }

    Text {
        id : subtitleItem
        text: subtitle
        visible : subtitle !== ""
        textStyle: component.style.subtitleTextStyle
        elide: Text.ElideRight

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: _iconSet ? component.style.titleKeyline * A.dp : component.style.leftPadding * A.dp
        anchors.rightMargin: parent.width - valueHolder.x
        anchors.bottomMargin: component.style.textBottomPadding * A.dp
    }

    Item {
        id: valueHolder
        anchors.right: parent.right
        anchors.rightMargin: component.style.rightPadding * A.dp
        width: childrenRect.width
        height: parent.height

        Text {
           id: valueItem
           textStyle: component.style.valueTextStyle
           text: value
           elide: Text.ElideRight

           anchors.top: parent.top
           anchors.bottom: parent.bottom
           anchors.topMargin: component.style.textTopPadding
           anchors.bottomMargin: component.style.textBottomPadding
         }
    }

    Loader {
        id : dividerLoader
        sourceComponent: component.style.divider

        anchors {
            left: parent.left
            leftMargin: dividerLeftInset
            right: parent.right
            bottom: parent.bottom
            rightMargin: dividerRightInset
        }
    }

}

