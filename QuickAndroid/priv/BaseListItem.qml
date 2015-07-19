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

    property string titleText
    property string valueText

    property bool interactive : true
    property bool selected : false

    property string iconSource : ""
    property size iconSourceSize : Qt.size(-1,-1)

    property alias icon : iconHolder.children

    property alias value : valueHolder.children

    signal clicked();

    property bool _iconSet : false

    color : component.style.backgroundColor

    anchors {
        left: parent.left
        right: parent.right
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
        spacing: 0
        anchors.fill: parent
        anchors.leftMargin: _iconSet ? component.style.titleKeyline : component.style.leftPadding;
        anchors.rightMargin: component.style.rightPadding

        ColumnLayout {

            spacing: 0
            id: titleHolder
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumHeight: rowLayout.height

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: component.style.topPadding
                Layout.minimumHeight: component.style.topPadding
            }

            Text {
                Layout.fillWidth: true
                id: titleItem
                text: titleText
                textStyle: component.style.titleTextStyle
                elide: Text.ElideRight
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: component.style.bottomPadding
                Layout.minimumHeight: component.style.bottomPadding
                Layout.alignment: Qt.AlignRight
            }
        }

        Item {
            id: spacer
            Layout.fillHeight: true
            Layout.maximumWidth: 8 * A.dp
            Layout.minimumWidth: 8 * A.dp
            Layout.maximumHeight: rowLayout.height
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
               text: valueText
               elide: Text.ElideRight

               anchors.top: parent.top
               anchors.bottom: parent.bottom
               anchors.topMargin: component.style.topPadding
               anchors.bottomMargin: component.style.bottomPadding
             }
        }

    }

    Loader {
        sourceComponent: component.style.divider

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }


}

