/* Text is a component based on QtQuick's text component. It has provided
   extra functions like style and gravity.

   License: Apache License
   Author : @benlau
   Project: https://github.com/benlau/quickandroid

 */

import QtQuick 2.0
import QtQuick 2.0 as Quick
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./Private"

Quick.Text {
    id: component

    // By default, it use normal text style
    property TextMaterial material: ThemeManager.currentTheme.text;

    // Set the type of the text. The text size and color will be changed according to the value.
    // Possible values : [Constants.smallText , Constants.normalText , Constants.mediumText , Constants.largeText ]
    property string type : ""

    // e.g Contants.center
    property string gravity: ""

    /// Normal text color
    property color textColor: material.textColor

    property color disabledTextColor : material.disabledTextColor

    font.pixelSize: component.material.textSize

    color : enabled ? textColor : disabledTextColor

    font.bold: material.bold

    onTypeChanged: {
        switch (type) {
        case Constants.normalText:
            material = ThemeManager.currentTheme.text;
            break;
        case Constants.smallText:
            material = ThemeManager.currentTheme.smallText;
            break;
        case Constants.largeText:
            material = ThemeManager.currentTheme.largeText;
            break;
        case Constants.mediumText:
            material = ThemeManager.currentTheme.mediumText;
            break;
        }
    }

    onGravityChanged: {
        switch (gravity) {
        case Constants.left:
            component.horizontalAlignment = Qt.AlignLeft;
            component.verticalAlignment = Qt.AlignVCenter;
            break;
        case Constants.right:
            component.horizontalAlignment = Qt.AlignRight;
            component.verticalAlignment = Qt.AlignVCenter;
            break;
        case Constants.top:
            component.horizontalAlignment = Qt.AlignCenter;
            component.verticalAlignment = Qt.AlignTop;
            break;
        case Constants.bottom:
            component.horizontalAlignment = Qt.AlignCenter;
            component.verticalAlignment = Qt.AlignBottom;
            break;
        case Constants.center:
            component.horizontalAlignment = Qt.AlignHCenter;
            component.verticalAlignment = Qt.AlignVCenter;
            break;
        case "topLeft":
            component.horizontalAlignment = Qt.AlignLeft;
            component.verticalAlignment = Qt.AlignTop;
            break;
        case "topRight":
            component.horizontalAlignment = Qt.AlignRight;
            component.verticalAlignment = Qt.AlignTop;
            break;
        case "bottomLeft":
            component.horizontalAlignment = Qt.AlignLeft;
            component.verticalAlignment = Qt.AlignBottom;
            break;
        case "bottomRight":
            component.horizontalAlignment = Qt.AlignRight;
            component.verticalAlignment = Qt.AlignBottom;
            break;
        }

    }
}

