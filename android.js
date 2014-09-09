.pragma library

/* quickandroid - Android Context - A helper to provide device information */

/* Density-independent pixel (dp) */

var dp = 1;

/* Screen DPI */
var dpi = 72;

function init(context) {
    dp = context.density || dp;
    dpi = context.dpi || dpi;
}

// Resolve the path of a drawable resource according to the current dp value
function resolve(resource) {

    // @TODO
//    if (quickAndroid) {
//        return quickAndroid.resolve(resource);
//    }

    var dpiTable = ["ldpi","mdpi","hdpi","xhdpi","xxhdpi","xxxhdpi"];
    var dpTable = [ 0.75,1,1.5,2,3,4];

    var index = -1;
    for (var i in  dpTable) {
        if (dpTable[i] === dp) {
            index = i;
            break;
        }
    }

    if (index === -1) {
        console.warn("Unknown DP value:",dp);
        return resource;
    }

    var token = resource.split("/");
    if (token.length < 2)
        return resource;

    var dir = token[token.length - 2];

    token[token.length-2] = dir +"-" + dpiTable[index];

    return token.join("/");
}

var application = null;
