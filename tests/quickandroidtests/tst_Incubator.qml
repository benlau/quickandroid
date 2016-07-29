import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import "../../QuickAndroid/Private/incubator.js" as Incubator

Rectangle {
    id : window
    width: 480
    height: 640


    TestSuite {
        name: "IncubatorTests"
        width : 480
        height : 480
        when : windowShown

        function test_loadingComponent() {
            var comp = Qt.createComponent(Qt.resolvedUrl("./components/DummyPage.qml"), Component.Asynchronous);
            compare(comp.status, Component.Loading);

            var incubator = Incubator.create(comp, window);
            compare(incubator.status, Component.Null);
            incubator.create();

            compare(incubator.status, Component.Loading);

            waitFor(incubator,"status", Component.Ready);
        }

        function test_errorComponent() {
            var comp = Qt.createComponent(Qt.resolvedUrl("./components/NonExisted.qml"), Component.Asynchronous);
            compare(comp.status, Component.Loading);

            var incubator = Incubator.create(comp, window);
            compare(incubator.status, Component.Null);
            incubator.create();

            compare(incubator.status, Component.Loading);

            waitFor(incubator,"status", Component.Error);

            console.log(incubator.errorString);
        }
    }


}
