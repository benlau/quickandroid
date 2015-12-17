import QtQuick 2.0
import QtTest 1.0

TestCase {

    function waitFor(object,prop, value, timeout) {
        if (timeout === undefined) {
            timeout = 1000;
        }

        var time = 0;

        while (object[prop] !== value) {
            wait(10);
            time+=10;

            if (time > timeout) {
                console.log("waitFor() - timeout");
                break;
            }
        }
    }

}

