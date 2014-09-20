import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

TestCase {
    name: "ResTests"
    width: 100
    height: 62

    function test_copy() {
        var src = {
            a : 1,
            b: {
                b1: 2.1,
                b2: 2.2
            },
            c: 3
        };

        var dst = {};

        Res.copy(dst,src);
        compare(dst["a"],undefined);

        dst = {
            a : "a",
            b : "b"
        }

        Res.copy(dst,src);
        compare(dst["a"],1);
        compare(dst.b.b1,2.1);
        compare(dst["c"],undefined);

        src.b.b1 = "b1"
        compare(src.b.b1,"b1");
        compare(dst.b.b1,2.1);


    }
}
