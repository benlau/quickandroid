/**
  Author: benlau
  Project: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import QuickAndroid 0.1

Material {
    property int textSize : 16 * A.dp
    property string textColor : Constants.black87
    property string disabledTextColor: textColor

    /// Sets whether the font weight is bold.
    property bool bold: false
}
