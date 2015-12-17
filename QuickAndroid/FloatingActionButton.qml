/** Floating Action Button

  TODO:
  - background property
 */
import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles 1.2 as ControlStyles
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Controls.Button {
    id: component

    width: size === Constants.large ? 56 * A.dp : 40 * A.dp
    height: width

    property size iconSourceSize : Qt.size(24 * A.dp,24 * A.dp);
    property color backgroundColor : material.backgroundColor
    property int depth: 1

    // Size of button. Possible values: [Constants.large, Constants.small]
    property string size: material.size

    property FloatingActionButtonMaterial material : ThemeManager.currentTheme.floatingActionButton

    style: FloatingActionButtonMaterialStyle {
    }

}

