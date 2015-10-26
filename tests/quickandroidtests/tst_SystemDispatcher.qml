import QtQuick 2.0
import QtQuick 2.0 as Quick

import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Rectangle {
    width: 480
    height: 640



    TestCase {
        name: "SystemDispatcher"
        width : 480
        height : 480
        when : windowShown

        function test_dispatch() {

            var received = false;
            function callback(type,message) {
                received = true;
            }

            SystemDispatcher.onDispatched.connect(callback);
            SystemDispatcher.dispatch("test");
            compare(received,true);

            wait(TestEnv.waitTime);
        }
    }
}

