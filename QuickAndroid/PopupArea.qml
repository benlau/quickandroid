/* @deprecated */
/* PopupArea delcares an area used as popup.
   Press out of the area will dismiss the popup by set the
   "active" property to false.
 */
import QtQuick 2.0

Item {
    id : popup
    property bool active : false
    property var _mouseArea;

    Component {
        id : popupMouseArea
        InverseMouseArea {
            anchors.fill: popup
            onPressed: {
                popup.active = false;
            }
        }
    }

    onActiveChanged: {
        if (active) {
            _mouseArea = popupMouseArea.createObject(popup);
            popup.focus = true
        } else {
            if (_mouseArea) {
                _mouseArea.parent = null;
                _mouseArea.destroy();
            }
            _mouseArea = null;
            popup.focus = false
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            popup.active = false;
            event.accepted = true;
        }
    }


}
