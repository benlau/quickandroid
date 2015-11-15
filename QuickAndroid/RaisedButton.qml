/* RaisedButton Component

   Author: Ben Lau
   License: Apache-2.0
   Project: https://github.com/benlau/quickandroid

 */

import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Button {
    id: button

    property RaisedButtonMaterial material: ThemeManager.currentTheme.raisedButton

    property string color: material.color
    property int depth: material.depth

    background: Rectangle {
        property bool pressed: false
        color: button.color

        MaterialShadow {
            asynchronous: true
            anchors.fill: parent
            z: -1
            depth: button.depth
        }

        Rectangle {
            anchors.fill: parent
            color:  pressed ? "#1A000000" : Constants.transparent
        }
    }
}

