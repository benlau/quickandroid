/** Application Theme Component (based on Material Design)

  Author : benlau
  Project: https://github.com/benlau/quickandroid
  Reference: http://developer.android.com/training/material/theme.html
 */

import QtQuick 2.0
import QuickAndroid 0.1

Material {
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

    property color colorPressed: Constants.black12

    // Animation

    property int activityDefaultDuration: 220
    property int activityShortDuration: 150

    // Metric
    property int keyline1: 16 * A.dp
    property int keyline2: 72 * A.dp

    // Normal test style
    property TextMaterial text : TextMaterial {
        textSize: 16 * A.dp
        textColor: Constants.black87
    }

    property TextMaterial smallText : TextMaterial {
        textSize: 14 * A.dp
        textColor : Constants.black87
    }

    property TextMaterial mediumText : TextMaterial {
        textSize: 18 * A.dp
        textColor : Constants.black87
    }

    property TextMaterial largeText : TextMaterial {
        textSize: 22 * A.dp
        textColor : Constants.black87
    }

    property ActivityStyle activity : ActivityStyle {
        activityEnterAnimation : Qt.resolvedUrl("../anim/ActivityEnter.qml")
        activityExitAnimation : Qt.resolvedUrl("../anim/ActivityExit.qml")
        background: windowBackground
    }

    property ButtonMaterial button: ButtonMaterial {
        colorPressed: theme.colorPressed
    }

    property RaisedButtonMaterial raisedButton: RaisedButtonMaterial {
        colorPressed: theme.colorPressed
        backgroundColor: colorPrimary
        text: TextMaterial {
            textSize: 14 * A.dp
            textColor: textColorPrimary
        }
    }

    property FloatingActionButtonMaterial floatingActionButton: FloatingActionButtonMaterial {
        backgroundColor: colorAccent
        colorPressed: theme.colorPressed
    }

    property ActionBarMaterial actionBar : ActionBarMaterial {
        backgroundColor: colorPrimary
        actionButtonBackground :button.background
        title: TextMaterial {
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

    property DialogMaterial dialog : DialogMaterial {
        tintColor: colorAccent
    }

    property ListItemMaterial listItem : ListItemMaterial {
        leftPadding: keyline1
        rightPadding: keyline1
        titleKeyline: keyline2
    }

    property DropDownMenuMaterial dropDownMenu: DropDownMenuMaterial {
        topPadding: 8 * A.dp
        bottomPadding: 8 * A.dp
    }

    property TabBarMaterial tabBar : TabBarMaterial {
        backgroundColor: colorPrimary
        indicatorColor: colorAccent
        textColor: textColorPrimary
        colorPressed: theme.colorPressed
    }

    property TextFieldMaterial textField: TextFieldMaterial {
        color: theme.colorAccent
    }

    property PageMaterial page: PageMaterial {
        backgroundColor: windowBackground
    }

    // Allow to place children under Theme.
    default property alias children: theme.__children
    property list<QtObject> __children: [QtObject {}]
}
