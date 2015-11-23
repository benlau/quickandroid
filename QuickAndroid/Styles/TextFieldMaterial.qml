import QtQuick 2.0
import QuickAndroid 0.1

Material {
    id: style

    // The style of input text
    property TextMaterial text : TextMaterial {
        textSize: 16 * A.dp
        textColor: Constants.black87
        disabledTextColor: Constants.black54
    }

    // The color of underline and floating text label on active.
    property string color

    property string disabledColor : Constants.black54

    property string inactiveColor : Constants.black54

    property string placeholderTextColor: Constants.black54
}

