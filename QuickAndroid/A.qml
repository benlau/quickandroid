/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Web: https://github.com/benlau/quickandroid
*/

import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Private 0.1
pragma Singleton


/*!
   \qmltype A
   \inqmlmodule QuickAndrid
   \brief A helper component to access Android specific information
 */

QtObject {
    id: a

    /*!
      \qmlproperty real dp
      Device Independent Pixel value

     */

    property real dp : 1;

    property real dpi : 72;

    /// Convert DP value to pixel value.
    function px(dp) {
        return dp * a.dp;
    }


    /*!
      \qmlmethod drawable(name,tintColor)

      Return an URL of drawable resource by given the resource name and tintColor(optional)

      Example:
      A.drawable("ic_back"); // Return image://drawable/ic_back

      A.drawable("ic_back","#ffffff"); // Return image://drawable/ic_back?tintColor=%23deffffff

     */

    function drawable(name,tintColor) {
        var url = "image://drawable/" + name;
        if (tintColor !== undefined) {
            url += "?tintColor=" + escape(tintColor);
        }
        return url;
    }

    /*!
      It is equivalent to Javascript setTimeout() function
     */

    function setTimeout(func,interval) {
        return TimerUtils.setTimeout(func,interval);
    }

    Component.onCompleted: {
        dp = Device.dp;
        dpi = Device.dpi;
    }

}

