import QtQuick 2.0
import QuickAndroid.style 0.1
pragma Singleton

Theme {
    mediumText.textSize: 18
    smallText.textSize : 14
    actionBar.background : "#cddc39" // Lime 500

    // actionBar.titleTextStyle.textSize is not allowed in QML. You should declare your own TextStyle and assign directly.
    // or modify text , smallText , mediumText and largetText
    actionBar.titleTextStyle : customTextStyle1

    // Custom Style object.
    TextStyle {
        id : customTextStyle1
        textSize: 18
        textColor : Style.theme.black87
    }
}

