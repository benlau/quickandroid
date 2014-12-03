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

    Repeater {
        model: ["enabled",
            "pressed",
            "focused",
            "selected",
            "checkable",
            "checked",
            "first",
            "last",
            "middle",
            "single"]

        delegate: Item {
            Binding {
                target: stateListDrawable.item
                property: modelData
                value: stateListDrawable[modelData]
                when: stateListDrawable.item !== null &&
                      stateListDrawable.item.hasOwnProperty(modelData)
            }
        }

    }
}
