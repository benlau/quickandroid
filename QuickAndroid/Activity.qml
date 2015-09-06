// Pretend Android's activity class but in fact it is just a page of UI

import QtQuick 2.0
import QuickAndroid 0.1
import "./style"

FocusScope {
    id : activity
    focus : true

    property Component actionBar : null

    /// This hold the actionBar item created from actionBar component
    property Item actionBarItem : actionBarLoader.item

    property var application : null

    property bool noHistory : false

    property alias background : backgroundDrawable.source

    default property alias content : contentHolder.data

    signal back

    property ActivityStyle style : ActivityStyle {
        activityEnterAnimation: Style.theme.activity.activityEnterAnimation
        activityExitAnimation: Style.theme.activity.activityExitAnimation
        background: Style.theme.activity.background
    }

    // It is emitted after the activity is started after page transition
    signal started

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
        z: -1
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            event.accepted = onBackKeyPressed();
        }
    }

    Loader {
        id : actionBarLoader
        sourceComponent: activity.actionBar

        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        z: contentHolder.z + 1;
    }

    Item {
        id: contentHolder
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: actionBarLoader.bottom
        anchors.bottom: parent.bottom
    }
}
