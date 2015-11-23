import QtQuick 2.0
import "./utils.js" as Utils


QtObject {
    /// Once the component loading is completed, it will merge the items in "override" array to this object.
    property var extend: []

    function merge() {
        return Utils.merge.apply(this,arguments);
    }

    Component.onCompleted: {
        if (extend) {
            var objects = [this];

            if (extend.hasOwnProperty("length")) {
                for (var i in extend) {
                    objects.push(extend[i]);
                }
            } else {
                objects.push(extend);
            }
            merge.apply(this,objects);
        }
    }
}

