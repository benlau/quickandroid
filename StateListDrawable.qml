import QtQuick 2.0

Drawable {
    id : stateListDrawable
    property bool pressed
    property bool selected
    property bool focused
    property bool activated
    property bool checkable
    property bool checked
    property bool first
    property bool last
    property bool middle
    property bool single

    onItemChanged: {
        var properties = ["enabled",
                          "pressed",
                          "focused",
                          "selected",
                          "checkable",
                          "checked",
                          "first",
                          "last",
                          "middle",
                          "single"]

        if (!item)
            return;

        for (var i in properties) {
            var p = properties[i];
            if (item.hasOwnProperty(p)) {
                (function(prop) {

                    item[prop] = Qt.binding(function() {
                        return stateListDrawable[prop];
                    });

                })(p);
            }
        }
    }
}
