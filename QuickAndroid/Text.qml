/* Text is a component based on QtQuick's text component. It has provided
   extra functions like style and gravity.

   License: Apache License
   Author : @benlau
   Project: https://github.com/benlau/quickandroid

 */

import QtQuick 2.0
import QtQuick 2.0 as Quick
import QuickAndroid 0.1
import "./style"
import "./priv"
import "./def"

Quick.Text {
    id: component

    property TextStyle textStyle
    property int textStyleType : -1
    property alias gravity : textBehaviour.gravity

    font.pixelSize: Style.theme.text.textSize * A.dp
    color : Style.theme.text.textColor

    TextBehaviour {
        id: textBehaviour
    }

    Modifier {
        target: textBehaviour;property: "textStyle";value: Style.theme.text;when: component.textStyleType === Constant.normalTextStyle && component.textStyle === null
    }
    Modifier {
        target: textBehaviour;property: "textStyle";value: Style.theme.smallText;when: component.textStyleType === Constant.smallTextStyle && component.textStyle === null
    }
    Modifier {
        target: textBehaviour;property: "textStyle";value: Style.theme.mediumText;when: component.textStyleType === Constant.mediumTextStyle && component.textStyle === null
    }
    Modifier {
        target: textBehaviour;property: "textStyle";value: Style.theme.largeText;when: component.textStyleType === Constant.largeTextStyle && component.textStyle === null
    }
    Modifier {
        target: textBehaviour;property: "textStyle";value: component.textStyle; when: component.textStyle !== null
    }
}

