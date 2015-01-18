// Dialog interface
import QtQuick 2.0
import QtQuick.Window 2.1
import "./style"

Drawable {
    id: dialog
    opacity: 0
    enabled: false

    signal rejected
    signal accepted

    // The result code on done. If the no. of chooce may than
    // 2, you should listen onResultChanged to obtain the correct
    // result
    property int result;

    property bool active: false

    property DialogStyle style : DialogStyle {
        windowEnterAnimation: Style.theme.dialog.windowEnterAnimation
        windowExitAnimation:  Style.theme.dialog.windowExitAnimation
    }

    function open() {
        active = true
    }

    function close() {
        active = false;
    }

    function reject() {
        done(0);
    }

    function accept() {
        done(1);
    }

    function done(code) {
        result = code;
        if (code === 0) {
            rejected();
        } else {
            accepted();
        }
        active = false;
    }

    Rectangle {
        id : mask
        anchors.centerIn: parent
        opacity: 0.5
        width: Screen.width
        height: Screen.height
        scale : 1 / dialog.scale
        z: -10000
        color : "#000000"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                dialog.active = false
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        z: -100
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back ||
            event.key === Qt.Key_Escape) {
            dialog.active = false;
            event.accepted = true;
        }
    }

    states: [
        State {
            name: "Active"
            when : active

            PropertyChanges {
                target : dialog
                opacity : 1
                focus: true
                enabled : true
            }
        }
    ]

    AnimationLoader {
        id : enterAnimation
        transition: fromNullToActive
        source : dialog.style.windowEnterAnimation
        target: dialog
    }

    AnimationLoader{
        id : exitAnimation
        transition: fromActiveToNull
        source : dialog.style.windowExitAnimation
        target: dialog
    }

    transitions: [Transition {
            id: fromNullToActive
            from: ""
            to: "Active"
        },
        Transition {
            id: fromActiveToNull
            from: "Active"
            to: ""
        }
    ]

}
