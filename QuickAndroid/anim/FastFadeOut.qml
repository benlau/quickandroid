import QtQuick 2.0
// Reference: fast_fade_out.xml

PropertyAnimation {
    property : "opacity"
    from : 1.0
    to : 0.0
    duration: 140
    easing.type: Easing.InQuad
}
