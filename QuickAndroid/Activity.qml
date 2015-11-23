// Pretend Android's activity class but in fact it is just a page of UI

import QtQuick 2.0
import QuickAndroid 0.1
import "./Styles"

FocusScope {
    id : activity
    focus : true

    property alias actionBar : actionBarContainer.children

    property var application : null

    property bool noHistory : false

    property alias background : backgroundDrawable.source

    default property alias content : contentHolder.data

    signal back

    property ActivityStyle style : ThemeManager.currentTheme.activity

    // It is emitted after the activity is started after page transition
    signal started

    signal appear();

    signal disappear();

    function start(component,options) {
        if (!application) {
            console.warn("Can not start activity. 'application' property is not set.");
            return;
        }

        return application.start(component,options);
    }

    function onBackKeyPressed() {
        // Override this function if you don't like this behavior
        if (!state) {
            return false;
        }

        state = "";
        return true;
    }

    Drawable {
        id : backgroundDrawable
        source : activity.style.background
        anchors.fill: parent
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            event.accepted = onBackKeyPressed();
        }
    }

    Item {
        id: actionBarContainer
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        z: contentHolder.z + 1;

        height: children.length > 0 ? childrenRect.height : 0
    }

    Item {
        id: contentHolder
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: actionBarContainer.bottom
        anchors.bottom: parent.bottom
    }

    Binding {
        target: actionBarContainer.children.length > 0 ? actionBarContainer.children[0] : null
        when: true
        property: "width"
        value: activity.width
    }
}
