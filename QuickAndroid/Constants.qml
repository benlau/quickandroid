import QtQuick 2.0
pragma Singleton

QtObject {
    property color black : "#000000"
    property color black87 : "#de000000"
    property color black54 : "#8a000000"
    property color black12 : "#1a000000"
    property color white87 : "#deffffff"
    property color white38 : "#61ffffff"
    property color transparent : "#00000000"


    property int normalTextStyle : 0
    property int smallTextStyle : 1
    property int mediumTextStyle : 2
    property int largeTextStyle : 3

    /* Text Size */
    property string smallText: "small"
    property string normalText: "normal"
    property string mediumText: "medium"
    property string largeText: "large"

    /* Alignment/Gravity */
    property string left : "left"
    property string right : "right"
    property string top : "top"
    property string bottom : "bottom"
    property string center : "center"
    property string leftTop : "leftTop"
    property string rightTop : "rightTop"
    property string leftBottom : "leftBottom"
    property string rightBottom : "rightBottom"

    // The z value of popup layer
    property int zPopupLayer : 100000000
}

