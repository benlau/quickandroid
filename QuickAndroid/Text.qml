/* Text is a component based on QtQuick's text component. It has provided
   extra functions like style and gravity.

   License: Apache License
   Author : @benlau
   Project: https://github.com/benlau/quickandroid

 */

import QtQuick 2.0
import QtQuick 2.0 as Quick
import "./style"
import "./priv"
import "./def"

Quick.Text {
    id: component

    property TextStyle textStyle
    property int textStyleType : Constant.normalTextStyle
    property alias gravity : textBehaviour.gravity

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

