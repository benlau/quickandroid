package quickandroid.example;

import android.test.ActivityInstrumentationTestCase2;
import android.util.Log;
import quickandroid.SystemMessenger;
import java.util.Map;
import android.content.Intent;
import android.test.ActivityTestCase;
import android.app.Instrumentation;
import android.app.Activity;
import java.util.Queue;
import java.util.LinkedList;
import java.util.ArrayList;
import java.util.List;

/**
 * This is a simple framework for a test of an Application.  See
 * {@link android.test.ApplicationTestCase ApplicationTestCase} for more information on
 * how to write and extend Application tests.
 * <p/>
 * To run this test, you can type:
 * adb shell am instrument -w \
 * -e class quickandroid.example.ExampleActivityTest \
 * quickandroid.example.tests/android.test.InstrumentationTestRunner
 */
public class ExampleActivityTest extends ActivityInstrumentationTestCase2<ExampleActivity> {

    private static String TAG = "ExampleActivityTest";

    public ExampleActivityTest() {
        super("quickandroid.example", ExampleActivity.class);
    }

    private static boolean launched = false;
    private static Activity mActivity = null;

    private void startActivity() {
        if (launched)
            return;

        Instrumentation instrumentation = getInstrumentation();
        Intent intent = new Intent(getInstrumentation()
                .getTargetContext(), ExampleActivity.class);
        intent.setFlags(intent.getFlags()  | Intent.FLAG_ACTIVITY_NEW_TASK);

        mActivity = instrumentation.startActivitySync(intent);
        launched = true;
    }

    private int counter = 0;

    public void testSendMessage() {
        startActivity();
        Log.v(TAG,"testSendMessage");

        SystemMessenger.Listener listener = new SystemMessenger.Listener() {

            public void post(String name , Map data) {
                Log.v(TAG,"Listener::post");

                if (name.equals("testSendMessage")) {
                    counter++;
                }
            }
        };

        SystemMessenger.addListener(listener);
        assertTrue(counter == 0);

        SystemMessenger.post("testSendMessage",null);

        assertEquals(counter , 1);

        SystemMessenger.removeListener(listener);

        SystemMessenger.post("testSendMessage",null);
        assertTrue(counter == 1);

    }

    private List<String> messages ;

    public void testReentrant() {
        startActivity();
        messages = new ArrayList();

        Log.v(TAG,"testReentrant");
        final String messageName = "testReentrant";

        SystemMessenger.Listener listener = new SystemMessenger.Listener() {

            public void post(String name , Map data) {
                messages.add(name);
                if (name.equals("ping")) {
                    counter++;
                    SystemMessenger.post("pong");
                } else if (name.equals("poing")) {
                    counter++;
                }
                return;
            }
        };

        SystemMessenger.addListener(listener);
        SystemMessenger.addListener(listener);

        assertTrue(messages.size() == 0);

        SystemMessenger.post("ping",null);
        assertEquals(messages.size() , 6);
        assertTrue(messages.get(0).equals("ping"));
        assertTrue(messages.get(1).equals("ping"));
        assertTrue(messages.get(2).equals("pong"));
        assertTrue(messages.get(3).equals("pong"));
        assertTrue(messages.get(4).equals("pong"));
        assertTrue(messages.get(5).equals("pong"));


        SystemMessenger.removeListener(listener);
        SystemMessenger.removeListener(listener);
    }



}
