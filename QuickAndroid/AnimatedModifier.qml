// An implementation of Binding component but it don't restore the value when it goes inactive. Moreover, it will use an PropertyAnimation to modify the value.
import QtQuick 2.0

Item {

    /* This property holds when the modifier is active. This should be set to an expression that evaluates to true when you want the binding to be active.

      Unlike Binding component , it won't restore the original when it goes inactive.
     */

    property bool when

    property var value

    property alias target : anim.target

    property alias property : anim.property

    property alias duration : anim.duration

    onValueChanged: {
        if (when)
            _run();
    }

    onWhenChanged: {
        if (when) {
            _run();
        } else {
            anim.stop();
        }
    }

    NumberAnimation {
        id : anim
        duration: 100;
        easing.type: Easing.Linear
    }

    function _run(){
        if (!target || !property)
            return;
        if (target[property] === value)
            return;

        if (anim.running)
            anim.stop();

        anim.from = target[property];
        anim.to = value
        anim.start();
    }

    Component.onCompleted: {
        if (!target || !property || !when)
            return;
        target[property] = value;
    }
}
