/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Web: https://github.com/benlau/quickandroid
*/

import QtQuick 2.0
pragma Singleton

/*!
   \qmltype ThemeManager
   \inqmlmodule QuickAndrid.Styles 0.1
   \brief A singleton object to manage theme default parameter.
 */

QtObject {
    property Theme currentTheme : Theme {
    }
}
