import QtQuick 2.0
import QuickAndroid 0.1
pragma Singleton

QtObject {

    property real dp : 1;
    property real dpi : 72;


    Component.onCompleted: {
        dp = Device.dp;
        dpi = Device.dpi;
    }

}

