import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Rectangle {
    id : window
    width: 480
    height: 640


    TestCase {
        name: "ATests"
        width : 480
        height : 480
        when : windowShown

        function test_timeout() {
            var count = 0;
            A.setTimeout(function() {
                count++;
            },200);
            compare(count,0);
            wait(100);
            compare(count,0);
            wait(300);
        }
    }

}
