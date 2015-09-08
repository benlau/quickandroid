import QtQuick 2.0
import QuickAndroid.Styles 0.1
pragma Singleton

Theme {
    mediumText.textSize: 18
    smallText.textSize : 14

    windowBackground: "#eeeeee";

    // Background with shadow
    actionBar.background : Qt.resolvedUrl("./ActionBarBackground.qml");

    // actionBar.titleTextStyle.textSize is not allowed in QML. You should declare your own TextStyle and assign directly.
    // or modify text , smallText , mediumText and largetText
    actionBar.titleTextStyle : customTextStyle1;

    // Custom Style object.
    TextStyle {
        id : customTextStyle1
        textSize: 18
        textColor : Style.theme.black87
    }
}

