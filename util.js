.pragma library

function connectOnce(sig,callback) {
    var func = function() {
        sig.disconnect(func);
        callback();
    }

    sig.connect(func);
}
