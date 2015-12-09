/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Website: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles 1.2 as ControlsStyles
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import QuickAndroid.Private 0.1


/*!
   \qmltype Button
   \inqmlmodule QuickAndrid 0.1
   \brief Button Component
 */

Controls.Button {

    id: button

    property ButtonMaterial material: ThemeManager.currentTheme.button

    property size iconSourceSize : material.iconSourceSize

    property Component background : material.background

    property color textColor: material.text.textColor

    /// The text size in sp unit
    property int textSize: material.text.textSize

    /// Specifies that icon and background on the local filesystem should be loaded asynchronously in a separate thread. The default value is false, causing the user interface thread to block while the it is loading.
    property bool asynchronous : material.asynchronous

    signal pressAndHold;

    Timer {
        id: pressAndHoldTimer
        interval: 800
        repeat: false;

        onTriggered: {
            pressAndHold();
        }
    }

    onPressedChanged: {
        if (pressed) {
            pressAndHoldTimer.start();
        } else {
            pressAndHoldTimer.stop();
        }
    }


    style: ButtonMaterialStyle {
    }
}

