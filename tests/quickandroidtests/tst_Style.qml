import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Rectangle {
    id: window
    width: 480
    height: 640

    ActionBarMaterial {
        id: style1

        iconSourceSize: Qt.size(47,47);
        title: TextMaterial {
            textSize: 23
        }
        keyline1: 8
    }

    ActionBarMaterial {
        id: style2

        extend:[ style1,{
            keyline2: 33,
            keyline1: 12
        }]
    }

    ActionBarMaterial {
        id: style3

        extend: ({
            keyline2: 43,
            keyline1: 9
        })
    }

    ActionBarMaterial {
        id: defaultStyle
    }

    Component {
        id: creator
        ActionBarMaterial {

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
                            "title.textSize": 99
                          })

            compare(cloned.title.textSize,99);
        }

        function test_merge() {
            var cloned = creator.createObject();
            cloned.merge(cloned,style1);
            compare(cloned.iconSourceSize.width,style1.iconSourceSize.width);
            compare(cloned.title.textSize,23);
            compare(cloned.keyline1,8);

            // Proof that it is performed deep copy for Qt.size() type
            cloned.iconSourceSize.width = 45;
            cloned.title.textSize = 50;
            compare(style1.iconSourceSize.width,47);
            compare(style1.title.textSize,23);

        }

        function test_mergeWithArg() {
            var cloned = creator.createObject();

            cloned.merge(cloned,style1,{
                           "keyline1": 36
                          });

            compare(cloned.iconSourceSize.width,style1.iconSourceSize.width);
            compare(cloned.title.textSize,23);
            compare(cloned.keyline1,36);

            // Proof that it is performed deep copy for Qt.size() type
            cloned.iconSourceSize.width = 33;
            cloned.title.textSize = 50;
            compare(style1.iconSourceSize.width,47);
            compare(style1.title.textSize,23);
        }

        function test_extend() {
            compare(style2.keyline2,33);
            compare(style2.keyline1,12);
            compare(style2.title.textSize,23);

            compare(style3.keyline2,43);
            compare(style3.keyline1,9);

        }

        Component {
            id: textCreator
            TextMaterial {
            }
        }

        function test_text() {
            // Unless it is specificed, disabledTextColor should be same as textColor by default
            var text = textCreator.createObject();
            text.textColor = "#00C0C0";
            compare(text.disabledTextColor,"#00C0C0");
        }

        function test_invalid() {
            console.log("Going to test invalid data");
            var style = creator.createObject();

            style.merge(style,{
                         "a.text": true
                        });

            style.merge(style,{
                         "nonExisted": true
                        });

        }
    }
}

