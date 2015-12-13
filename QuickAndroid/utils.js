.pragma library

function connectOnce(sig,callback) {
    var func = function() {
        sig.disconnect(func);
        callback();
    }

    sig.connect(func);
}

// A helper function to create object from QML file / Component.
function createObject(source,parent,options, asynchronous) {
    var view;

    if (asynchronous === undefined)
        asynchronous = false;

    options = options === undefined ? {} : options;

    if (typeof source === "string") {
        var comp;

        comp = Qt.createComponent(source);

        if (comp === undefined || comp.status === 3) { // Component.Error
            console.warn("Error loading QML source: ",source);
            console.warn(comp.errorString());
            return;
        }
        source = comp;
    }

    if (String(source).indexOf("QQmlComponent") === 0) {
        // It is a component object
        if (asynchronous) {

            view = source.incubateObject(parent, options, Qt.Asynchronous);

        } else {

            view = source.createObject(parent,options || {});
            if (view === null) {
                console.warn("createObject() failed:", source.errorString());
                return;
            }
        }
    } else { // It is an already created object
        view = source;
        view.parent = parent;
    }

    return view;
}
