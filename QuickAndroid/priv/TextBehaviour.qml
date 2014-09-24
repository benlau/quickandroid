// Modify the beahviour of Text component
import QtQuick 2.0

Item {
    id : behaviour
    property var target: parent
    property string gravity

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "left";value: TextInput.AlignLeft}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "left";value: TextInput.AlignVCenter}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "right";value: TextInput.AlignRight}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "right";value: TextInput.AlignVCenter}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "top";value: TextInput.AlignCenter}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "top";value: TextInput.AlignTop}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "bottom";value: TextInput.AlignCenter}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "bottom";value: TextInput.AlignBottom}

    Binding{ target: behaviour.target;property:"horizontalAlignment";when: gravity === "center";value: TextInput.AlignCenter}
    Binding{ target: behaviour.target;property:"verticalAlignment";  when: gravity === "center";value: TextInput.AlignVCenter}

}
