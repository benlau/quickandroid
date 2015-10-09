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
        id: style2

        extend:[ style1,{
            keyline2: 33,
            keyline1: 12
        }]
    }

    ActionBarStyle {
        id: defaultStyle
    }

    Component {
        id: creator
        ActionBarStyle {

        }
    }

    TestCase {
        name: "StyleTests"
        width : 480
        height : 480
        when : windowShown

        function test_merge_dotted() {
            var cloned = creator.createObject();
            style1.merge(cloned,style1,{
                            "titleTextStyle.textSize": 99
                          })

            compare(cloned.titleTextStyle.textSize,99);
        }

        function test_merge() {
            var cloned = creator.createObject();
            cloned.merge(cloned,style1);
            compare(cloned.iconSourceSize.width,style1.iconSourceSize.width);
            compare(cloned.titleTextStyle.textSize,23);
            compare(cloned.keyline1,8);

            // Proof that it is performed deep copy for Qt.size() type
            cloned.iconSourceSize.width = 45;
            cloned.titleTextStyle.textSize = 50;
            compare(style1.iconSourceSize.width,47);
            compare(style1.titleTextStyle.textSize,23);

        }

        function test_mergeWithArg() {
            var cloned = creator.createObject();

            cloned.merge(cloned,style1,{
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

        function test_extend() {
            compare(style2.keyline2,33);
            compare(style2.keyline1,12);
            compare(style2.titleTextStyle.textSize,23);
        }

        Component {
            id: textStyleCreator
            TextStyle {
            }
        }

        function test_textStyle() {
            // Unless it is specificed, disabledTextColor should be same as textColor by default
            var textStyle = textStyleCreator.createObject();
            textStyle.textColor = "#00C0C0";
            compare(textStyle.disabledTextColor,"#00C0C0");
        }
    }
}

