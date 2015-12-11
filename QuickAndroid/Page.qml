/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Website: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import "./Transitions"
import "./Styles"
import "./utils.js" as Utils

/*!
   \qmltype Page
   \inqmlmodule QuickAndrid 0.1
   \brief Page Component
 */

FocusScope {
    id: page

    property alias actionBar : actionBarContainer.children

    property bool noHistory : false

    property color backgroundColor : material.backgroundColor

    default property alias content : contentHolder.data

    // It is emitted when the page is visible to user
    signal appear();

    // It is emitted when the page is not visible to user
    signal disappear();

    signal aboutToPresent();

    // It is emitted when the page become visible to user for first time.
    signal presented();

    signal aboutToDismiss();

    // It is emitted when the page bcome invisible and will never visible again
    signal dismissed();

    property Component transitionAnimation: GrowFadeInTransition {}

    property bool isPresented: false

    property var _transition

    property var stack: null

    property PageMaterial material: ThemeManager.currentTheme.page

    function present(source,properties,animated) {
        if (!stack) {
            var newPage = Utils.createObject(source,page.parent,properties);
            newPage.anchors.fill = page;
            return newPage;
        }

        return stack.push(source,properties,animated);
    }

    function dismiss(animated) {
        if (!stack) {
            disappear();
            destroy();
            return;
        }

        if (stack.topPage === page) {
            stack.pop(animated);
        } // @TODO remove middle page
    }

    function back() {
        dismiss(true);
    }

    function onBackKeyPressed() {
        // Override this function if you don't like this behavior
        return false;
    }

    onPresented: {
        isPresented = true;
    }

    Rectangle {
        anchors.fill: parent
        color: page.backgroundColor
    }

    MouseArea {
        // Block mouse area to parent
        anchors.fill: parent
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            id: actionBarContainer
            z: contentHolder.z + 1;
            height: children.length > 0 ? childrenRect.height : 0

            Layout.fillWidth: true
            Layout.fillHeight: false
        }

        Item {
            id: contentHolder

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Binding {
        target: actionBarContainer.children.length > 0 ? actionBarContainer.children[0] : null
        when: true
        property: "width"
        value: page.width
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            event.accepted = onBackKeyPressed();
        }
    }
}

