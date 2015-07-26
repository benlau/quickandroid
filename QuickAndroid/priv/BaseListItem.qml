import QtQuick 2.0
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import QuickAndroid.def 0.1

/*
  Reference:

  Lists: Controls - Components - Google design guidelines
  https://www.google.com/design/spec/components/lists-controls.html#
 */

Rectangle {
    id: component

    //@TODO : Read from Style.theme
    property ListItemStyle style : ListItemStyle {}

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
            color : Color.black12
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

    RowLayout {
        id: rowLayout
        spacing: 8 * A.dp
        anchors.fill: parent
        anchors.leftMargin: _iconSet ? component.style.titleKeyline : component.style.leftPadding;
        anchors.rightMargin: component.style.rightPadding

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: rowLayout.height

            ColumnLayout {
                spacing: 4 * A.dp
                anchors.fill: parent
                anchors.topMargin: component.style.textTopPadding
                anchors.bottomMargin: component.style.textBottomPadding
                id: titleHolder

                Text {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    id: titleItem
                    text: title
                    textStyle: component.style.titleTextStyle
                    elide: Text.ElideRight
                }

                Text {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    id : subtitleItem
                    text: subtitle
                    visible : subtitle !== ""
                    textStyle: component.style.subtitleTextStyle
                    elide: Text.ElideRight
                }
            }
        }

        Item {
            id: valueHolder
            Layout.fillHeight: true
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: childrenRect.width
            Layout.maximumHeight: rowLayout.height

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

