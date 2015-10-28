import QtQuick 2.0
import QtQuick.Layouts 1.1
import QuickAndroid 0.1

FocusScope {
    id: page

    property alias actionBar : actionBarContainer.children

    property bool noHistory : false

    property color backgroundColor : Constants.white100

    default property alias content : contentHolder.data

    // It is emitted when the page is visible to user
    signal appear();

    // It is emitted when the page is not visible to user
    signal disappear();

    Rectangle {
        anchors.fill: parent
        color: page.backgroundColor
    }

    MouseArea {
        // Block mouse area to parent
        anchors.fill: parent
    }


    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            id: actionBarContainer
            z: contentHolder.z + 1;
            height: children.length > 0 ? childrenRect.height : 0

            Layout.fillWidth: true
            Layout.fillHeight: false
        }

        Item {
            id: contentHolder

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Binding {
        target: actionBarContainer.children.length > 0 ? actionBarContainer.children[0] : null
        when: true
        property: "width"
        value: page.width
    }

}

