/** Application Theme Component (based on Material Design)

  Author : benlau
  Project: https://github.com/benlau/quickandroid
  Reference: http://developer.android.com/training/material/theme.html
 */

import QtQuick 2.0
import QuickAndroid 0.1

Style {
    id : theme

    // Color
    // Reference: https://github.com/android/platform_frameworks_base/blob/master/core/res/res/values/attrs.xml

    // Primary Color
    property string colorPrimary : "#00BCD4" // Cyan500
    property string colorPrimaryDark : "#00838F" // Cyan800

    property string colorForeground: "#FFF59D" //Yellow 200

    property string textColorPrimary : Constants.white87

    property string textColorSecondary: Constants.black54

    property color windowBackground: "#EFEFEF"

    property color navigationBarColor : "#FFFFFF"

    property string colorAccent : "#009688"

    // Animation

    property int activityDefaultDuration: 220
    property int activityShortDuration: 150

    // Metric
    property int keyline1: 16 * A.dp
    property int keyline2: 72 * A.dp

    // Normal test style
    property TextStyle text : TextStyle {
        textSize: 16 * A.dp
        textColor: Constants.black87
    }

    property TextStyle smallText : TextStyle {
        textSize: 14 * A.dp
        textColor : Constants.black87
    }

    property TextStyle mediumText : TextStyle {
        textSize: 18 * A.dp
        textColor : Constants.black87
    }

    property TextStyle largeText : TextStyle {
        textSize: 22 * A.dp
        textColor : Constants.black87
    }

    property ActivityStyle activity : ActivityStyle {
        activityEnterAnimation : Qt.resolvedUrl("../anim/ActivityEnter.qml")
        activityExitAnimation : Qt.resolvedUrl("../anim/ActivityExit.qml")
        background: windowBackground
    }

    property ButtonStyle button: ButtonStyle {
    }

    property RaisedButtonStyle raisedButton: RaisedButtonStyle {
        color: colorPrimary
        textStyle: TextStyle {
            textSize: 14 * A.dp
            textColor: textColorPrimary
        }
    }

    property FloatingActionButtonStyle floatingActionButton: FloatingActionButtonStyle {
        color: colorAccent
    }

    property ActionBarStyle actionBar : ActionBarStyle {
        background : "#E6E6E6"
        actionButtonBackground : Qt.resolvedUrl("../drawable/ItemBackgroundHoloLight.qml")
        titleTextStyle: TextStyle {
            textSize: 18*A.dp
            textColor: textColorPrimary
            disabledTextColor: textColorPrimary
        }
        homeAsUpIndicator : Qt.resolvedUrl("../drawable-xxhdpi/ic_ab_back_holo_light_am.png")
        divider : Constants.black12
        padding: 8 * A.dp
        keyline1: theme.keyline1
        keyline2: theme.keyline2
    }

    property SwitchStyle switchStyle : SwitchStyle {
        track: Qt.resolvedUrl("../drawable/SwitchBgHoloLight.qml")
        thumb: Qt.resolvedUrl("../drawable/SwitchThumbHoloLight.qml")
        textStyle: smallText
        thumbTextPadding: 12 * A.dp
        switchMinWidth: 96 * A.dp
        switchPadding: 16 * A.dp
    }

    property DialogStyle dialog : DialogStyle {
        tintColor: colorAccent
    }

    property ListItemStyle listItem : ListItemStyle {
        leftPadding: keyline1
        rightPadding: keyline1
        titleKeyline: keyline2
    }

    property DropDownMenuStyle dropDownMenu: DropDownMenuStyle {
        topPadding: 8 * A.dp
        bottomPadding: 8 * A.dp
    }

    property TabBarStyle tabBar : TabBarStyle {
        backgroundColor: colorPrimary
        indicatorColor: colorAccent
        textColor: textColorPrimary
    }

    property TextFieldStyle textField: TextFieldStyle {
        color: theme.colorAccent
    }

    // Allow to place children under Theme.
    default property alias children: theme.__children
    property list<QtObject> __children: [QtObject {}]
}
