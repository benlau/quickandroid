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
    property TextStyle aStyle: ThemeManager.currentTheme.text;

    // Set the type of the text. The text size and color will be changed according to the value.
    // Possible values : [Constants.smallText , Constants.normalText , Constants.mediumText , Constants.largeText ]
    property string type : ""

    // e.g Contants.center
    property string gravity: ""

    /// Normal text color
    property color textColor: aStyle.textColor

    property color disabledTextColor : aStyle.disabledTextColor

    font.pixelSize: component.aStyle.textSize

    color : enabled ? textColor : disabledTextColor
    font.bold: aStyle.bold

    Modifier {
        target: component; property: "aStyle"; value: ThemeManager.currentTheme.text;
        when: component.type === Constants.normalText
    }
    Modifier {
        target: component; property: "aStyle"; value: ThemeManager.currentTheme.smallText;
        when: component.type === Constants.smallText
    }
    Modifier {
        target: component; property: "aStyle"; value: ThemeManager.currentTheme.mediumText;
        when: component.type === Constants.mediumText
    }
    Modifier {
        target: component; property: "aStyle"; value: ThemeManager.currentTheme.largeText;
        when: component.type === Constants.largeText
    }


    /* Gravity */
    Binding{ target: component;property:"horizontalAlignment";when: gravity === "left";value: Qt.AlignLeft}
    Binding{ target: component;property:"verticalAlignment";  when: gravity === "left";value: Qt.AlignVCenter}

    Binding{ target: component;property:"horizontalAlignment";when: gravity === "right";value: Qt.AlignRight}
    Binding{ target: component;property:"verticalAlignment";  when: gravity === "right";value: Qt.AlignVCenter}

    Binding{ target: component;property:"horizontalAlignment";when: gravity === "top";value: Qt.AlignCenter}
    Binding{ target: component;property:"verticalAlignment";  when: gravity === "top";value: Qt.AlignTop}

    Binding{ target: component;property:"horizontalAlignment";when: gravity === "bottom";value: Qt.AlignCenter}
    Binding{ target: component;property:"verticalAlignment";  when: gravity === "bottom";value: Qt.AlignBottom}

    Binding{ target: component;property:"horizontalAlignment";when: gravity === "center";value: Qt.AlignHCenter}
    Binding{ target: component;property:"verticalAlignment";  when: gravity === "center";value: Qt.AlignVCenter}

    Binding{ target: component;property:"horizontalAlignment";when: gravity === "topLeft";value: Qt.AlignLeft}
    Binding{ target: component;property:"verticalAlignment";  when: gravity === "topLeft";value: Qt.AlignTop}

    Binding{ target: component;property:"horizontalAlignment";when: gravity === "topRight";value: Qt.AlignRight}
    Binding{ target: component;property:"verticalAlignment";  when: gravity === "topRight";value: Qt.AlignTop}

    Binding{ target: component;property:"horizontalAlignment";when: gravity === "bottomLeft";value: Qt.AlignLeft}
    Binding{ target: component;property:"verticalAlignment";  when: gravity === "bottomLeft";value: Qt.AlignBottom}

    Binding{ target: component;property:"horizontalAlignment";when: gravity === "bottomRight";value: Qt.AlignRight}
    Binding{ target: component;property:"verticalAlignment";  when: gravity === "bottomRight";value: Qt.AlignBottom}
}

