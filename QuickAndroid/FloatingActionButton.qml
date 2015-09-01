import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles 1.2 as ControlStyles
import QtGraphicalEffects 1.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Controls.Button {
    id: component

    width: 56 * A.dp
    height: 56 * A.dp

    property color color : Style.theme.colorPrimary
    property int depth: 1

    style: ControlStyles.ButtonStyle {
        background: Item {

            RectangularGlow {
                id: shadow
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height
                color: "#606060"

                cornerRadius: width / 2

                glowRadius: 0.1 * A.dp
                anchors.verticalCenterOffset: 1 * A.dp

                spread: 0.8

                Binding { target: shadow; property: "glowRadius"; when: component.depth === 2; value: 0.1 * A.dp;}
                Binding { target: shadow; property: "spread"; when: component.depth === 2; value: 0.4;}
                Binding { target: shadow; property: "anchors.verticalCenterOffset"; when: component.depth === 2; value: 10 * A.dp;}

                Binding { target: shadow; property: "glowRadius"; when: component.depth === 3; value: 0.2 * A.dp;}
                Binding { target: shadow; property: "spread"; when: component.depth === 3; value: 0.2;}
                Binding { target: shadow; property: "anchors.verticalCenterOffset"; when: component.depth === 3; value: 10 * A.dp;}

                Binding { target: shadow; property: "glowRadius"; when: component.depth === 4; value: 0.3 * A.dp;}
                Binding { target: shadow; property: "spread"; when: component.depth === 4; value: 0.1;}
                Binding { target: shadow; property: "anchors.verticalCenterOffset"; when: component.depth === 4; value: 10 * A.dp;}

                Binding { target: shadow; property: "glowRadius"; when: component.depth === 5; value: 0.6 * A.dp;}
                Binding { target: shadow; property: "spread"; when: component.depth === 5; value: 0;}
                Binding { target: shadow; property: "anchors.verticalCenterOffset"; when: component.depth === 5; value: 10 * A.dp;}

            }

            Rectangle {
                id: circle
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                color: component.color
                radius: width / 2
            }

            Rectangle {
                id: mask
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                color: "#1F000000"
                radius: width / 2
                visible: component.pressed
            }

        }

    }

}

