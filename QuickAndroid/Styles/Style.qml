import QtQuick 2.0

QtObject {
    property string componentName: "Style"

    /// Merge the contents of two or more objects together into the first object.
    function extend() {
        if (arguments.length === 0)
            return;

        var target = arguments[0];
        var reserved = ["objectName","componentName","extend","clone"];

        for (var i = 1; i< arguments.length; i++) {
            var object = arguments[i];

            for (var prop in object) {
                if (prop.match(/Changed$/))
                    continue;
                if (reserved.indexOf(prop) >= 0)
                    continue;

                if (typeof object[prop] === "object" &&
                    String(object[prop]).indexOf("QSize") !== 0) {
                    extend(target[prop],object[prop]);
                } else {
                    target[prop] = object[prop];
                }
            }

        }

        return target;
    }

    function clone(parent) {

        var qml = "import QtQuick 2.0; import QuickAndroid 0.1; " + componentName + " {}" ;
        var ret = Qt.createQmlObject(qml,parent);

        var objects = [ret,this];
        for (var i = 1 ; i < arguments.length; i++) {
            objects.push(arguments[1])
        }
        return extend.apply(ret,objects);
    }
}

