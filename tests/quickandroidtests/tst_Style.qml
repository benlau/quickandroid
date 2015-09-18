import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Rectangle {
    id: window
    width: 480
    height: 640

    ActionBarStyle {
        id: style1

        iconSourceSize: Qt.size(47,47);
        titleTextStyle: TextStyle {
            textSize: 23
        }
        keyline1: 8
    }

    ActionBarStyle {
        id: defaultStyle
    }

    TestCase {
        name: "StyleTests"
        width : 480
        height : 480
        when : windowShown

        function test_clone() {
            var cloned = style1.clone(window);
            compare(cloned.iconSourceSize.width,style1.iconSourceSize.width);
            compare(cloned.titleTextStyle.textSize,23);
            compare(cloned.keyline1,8);

            // Proof that it is performed deep copy for Qt.size() type
            cloned.iconSourceSize.width = 45;
            cloned.titleTextStyle.textSize = 50;
            compare(style1.iconSourceSize.width,47);
            compare(style1.titleTextStyle.textSize,23);

        }

        function test_cloneWithArg() {
            var cloned = style1.clone(window,{
                                       "keyline1": 36
                                      });

            compare(cloned.iconSourceSize.width,style1.iconSourceSize.width);
            compare(cloned.titleTextStyle.textSize,23);
            compare(cloned.keyline1,36);

            // Proof that it is performed deep copy for Qt.size() type
            cloned.iconSourceSize.width = 33;
            cloned.titleTextStyle.textSize = 50;
            compare(style1.iconSourceSize.width,47);
            compare(style1.titleTextStyle.textSize,23);
        }
    }
}

