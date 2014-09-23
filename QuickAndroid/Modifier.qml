// An implementation of Binding component but it don't restore the value when it goes inactive
import QtQuick 2.0

Item {

    /* This property holds when the modifier is active. This should be set to an expression that evaluates to true when you want the binding to be active.
      Unlike Binding component , it won't restore the original when it goes inactive.
     */

    property bool when

    property var value

    property var target

    property var property

    onValueChanged: {
        if (when)
            _set();
    }

    onWhenChanged: {
        if (when) {
            _set();
        }
    }

    onTargetChanged: {
        if (when)
            _set();
    }

    function _set(){
        if (!target || !property)
            return;
        if (target[property] === value)
            return;

        target[property] = value;
    }
}
