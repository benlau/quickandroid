import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
pragma Singleton

Theme {
    mediumText.textSize: 18 * A.dp
    smallText.textSize : 14 * A.dp

    colorPrimary: "#cddc39" // Lime 500
    textColorPrimary: Constants.black87
    windowBackground: "#eeeeee";

    // Background with shadow
    actionBar.iconSource: A.drawable("ic_keyboard_backspace",Constants.black87)
    actionBar.background : Qt.resolvedUrl("./ActionBarBackground.qml");

    // actionBar.titleTextStyle.textSize is not allowed in QML. You should declare your own TextStyle and assign directly.
    // or modify text , smallText , mediumText and largetText

    actionBar.titleTextStyle : customTextStyle1;
    actionBar.iconSourceSize: Qt.size(24 * A.dp , 24 * A.dp)

    // Custom Style object.
    TextStyle {
        id : customTextStyle1
        textSize: 18 * A.dp
        textColor : Constants.black87
    }
}

