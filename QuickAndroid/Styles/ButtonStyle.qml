import QtQuick 2.0
import QuickAndroid 0.1
QtObject {
    property var background: Qt.resolvedUrl("../drawable/BtnDefault.qml");

    property TextStyle textStyle: TextStyle {
        textSize: 14 * A.dp
        textColor: "#de000000"
    }
}

