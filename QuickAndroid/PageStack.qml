import QtQuick 2.0
import "./utils.js" as Utils

Item {
    id: pageStack

    property var initialPage

    property var currentPage

    property var history: new Array

    function push(source,properties,animated) {
        var page = Utils.createObject(source,pageStack,properties);
        history.push(page);

        page.anchors.fill = pageStack;
    }

    function pop() {
    }

    function back() {
        pop();
    }

    Component.onCompleted: {
        if (initialPage !== undefined) {
            push(initialPage,{},false);
        }
    }
}

