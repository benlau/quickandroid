// Modify the beahviour of Text component
import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Item {
    id : behaviour
    property var target: parent
    property string gravity

    /// Set to true if you want the text scale to a smaller size if the content exceed the width
    property bool shrink : false;

    property TextStyle textStyle

    property var _pixelSize : textStyle ?  textStyle.textSize * A.dp : undefined
    property var _color : textStyle ? textStyle.textColor : undefined

    /* textAppearance */
    Binding { target: behaviour.target;property: "font.pixelSize";when: textStyle !== undefined; value: _pixelSize}
    Binding { target: behaviour.target;property: "color";when: textStyle !== undefined; value: _color}

    Binding { target: behaviour.target; property: "scale"; when: shrink && behaviour.target.contentWidth > behaviour.target.width; value: behaviour.target.width / behaviour.target.contentWidth}

    /* Gravity */
    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "left";value: Qt.AlignLeft}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "left";value: Qt.AlignVCenter}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "right";value: Qt.AlignRight}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "right";value: Qt.AlignVCenter}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "top";value: Qt.AlignCenter}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "top";value: Qt.AlignTop}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "bottom";value: Qt.AlignCenter}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "bottom";value: Qt.AlignBottom}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "center";value: Qt.AlignHCenter}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "center";value: Qt.AlignVCenter}


    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "topLeft";value: Qt.AlignLeft}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "topLeft";value: Qt.AlignTop}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "topRight";value: Qt.AlignRight}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "topRight";value: Qt.AlignTop}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "bottomLeft";value: Qt.AlignLeft}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "bottomLeft";value: Qt.AlignBottom}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "bottomRight";value: Qt.AlignRight}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "bottomRight";value: Qt.AlignBottom}

}
