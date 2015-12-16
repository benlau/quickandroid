import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : window
    width: 480
    height: 640
    focus: true;

    Page {
        id: page
        focus: true;

        Dialog {
            id: dialog
        }
    }

    TestCase {
        name: "DialogTests_activeFocs"
        width : 480
        height : 480
        when : windowShown

        function test_issue14() {
            page.forceActiveFocus();
            var fields = { activeFocus: true};
            var items = Testable.filter(page,fields);
            compare(items.length, 1);
            compare(items[0], page);

            dialog.open();

            wait(200);

            items = Testable.filter(page,fields);

            // Dialog will gain focus on open
            compare(items.length, 2);
            compare(items[0] === page, true);
            compare(items[1] === dialog, true);

            dialog.close();

            items = Testable.filter(page,fields);
            compare(items.length, 1);
            compare(items[0] === page, true);

            wait(TestEnv.waitTime);
        }
    }

}
