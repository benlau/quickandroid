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

    // The default icon of ActionBar is a "back" image
    actionBar.iconSource: A.drawable("ic_arrow_back",Constants.black87)

    // Background with shadow
    actionBar.background: ActionBarBackground {
    }

    // actionBar.title.textSize is not allowed in QML. You should declare your own TextMaterial and assign directly.
    // or modify text , smallText , mediumText and largetText
    actionBar.title : customTextMaterial1;
    actionBar.iconSourceSize: Qt.size(24 * A.dp , 24 * A.dp)

    // Custom Style object.
    TextMaterial {
        id : customTextMaterial1
        textSize: 18 * A.dp
        textColor : Constants.black87
    }
}

