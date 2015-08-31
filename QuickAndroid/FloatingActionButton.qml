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

    style: ControlStyles.ButtonStyle {
        background: Item {

            RectangularGlow {
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                color: component.color
                spread: 0.83
                cornerRadius: width/2
                glowRadius: 0.3 * A.dp
                clip: true
                opacity: component.pressed ? 0.2 : 1
            }
        }

    }

}

