import QtQuick 2.0

QtObject {
    /// Once the component loading is completed, it will merge the items in "override" array to this object.
    property var extend: []

    /// Merge the contents of two or more objects together into the first object.
    function merge() {
        if (arguments.length === 0)
            return;

        if (arguments.length === 1)
            return arguments[0];

        var target = arguments[0];
        var reserved = ["objectName","extend","merge"];

        for (var i = 1; i< arguments.length; i++) {
            var object = arguments[i];

            for (var prop in object) {
                if (prop.match(/Changed$/))
                    continue;
                if (reserved.indexOf(prop) >= 0)
                    continue;

                if (prop.indexOf(".") >= 0) {
                    var token = prop.split(".");
                    var newProp = token.splice(0,1)[0];
                    var remainingProp = token.join(".");
                    var newObject = {};

                    if (!target.hasOwnProperty(newProp)) {
                        console.warn("Style.merge() - can not merge property: \"" + prop + "\"");
                        continue;
                    }

                    newObject[remainingProp] = object[prop];
                    merge(target[newProp],newObject);
                } else if (typeof object[prop] === "object" &&
                    String(object[prop]).indexOf("QSize") !== 0) {
                    merge(target[prop],object[prop]);
                } else {
                    target[prop] = object[prop];
                }
            }

        }

        return target;
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

