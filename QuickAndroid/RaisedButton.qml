/* RaisedButton Component

   Author: Ben Lau
   License: Apache-2.0
   Project: https://github.com/benlau/quickandroid

 */

import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./Private"

Button {
    id: button

    property RaisedButtonMaterial material: ThemeManager.currentTheme.raisedButton

    property color backgroundColor: material.backgroundColor

    property int depth: material.depth

    background: Rectangle {

        opacity: button.enabled ? 1 : material.disabledOpacity

        color: button.backgroundColor
        clip: true

        MaterialShadow {
            asynchronous: true
            anchors.fill: parent
            z: -1
            depth: button.depth
        }

        Ink {
            mouseArea: control.__behavior
            anchors.fill: parent
            color: material.colorPressed
        }
    }
}

