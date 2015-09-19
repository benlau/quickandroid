import QtQuick 2.0
import QuickAndroid 0.1
pragma Singleton

QtObject {
    id: a

    /// Device Independent Pixel value
    property real dp : 1;

    property real dpi : 72;

    /* Return an URL of drawable resource by given the resource name and tintColor(optional)

      Example:
      A.drawable("ic_back"); // Return image://drawable/ic_back

      A.drawable("ic_back","#ffffff"); // Return image://drawable/ic_back?tintColor=%23deffffff

      A.drawable("ic_back","ffffff"); // Return image://drawable/ic_back?tintColor=ffffff
                                      // Without "#" is still working

     */

    /// Convert DP value to pixel value.
    function px(dp) {
        return dp * a.dp;
    }

    function drawable(name,tintColor) {
        var url = "image://drawable/" + name;
        if (tintColor !== undefined) {
            url += "?tintColor=" + escape(tintColor);
        }
        return url;
    }


    Component.onCompleted: {
        dp = Device.dp;
        dpi = Device.dpi;
    }

}

