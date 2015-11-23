/**
  Author: benlau
  Project: https://github.com/benlau/quickandroid
 */
import QtQuick 2.0
import QuickAndroid 0.1

Material {
    property var background: Qt.resolvedUrl("../drawable/BtnDefault.qml");

    /// Specifies that icon and background on the local filesystem should be loaded asynchronously in a separate thread. The default value is false, causing the user interface thread to block while the it is loading.
    property bool asynchronous : false

    // Expected icon source size
    property size iconSourceSize

    property real disabledOpacity: 0.54

    property TextMaterial text: TextMaterial {
        textSize: 14 * A.dp
        textColor: Constants.black87
        disabledTextColor: Constants.black54
    }
}

