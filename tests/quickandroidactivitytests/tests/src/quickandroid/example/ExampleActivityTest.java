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
//        Log.v(TAG,String.format("Pre StartActivity: %b",launched));

        if (launched)
            return;

        Log.v(TAG,"StartActivity");

        Instrumentation instrumentation = getInstrumentation();
        Intent intent = new Intent(getInstrumentation()
                .getTargetContext(), ExampleActivity.class);
        intent.setFlags(intent.getFlags()  | Intent.FLAG_ACTIVITY_NEW_TASK);

        mActivity = instrumentation.startActivitySync(intent);
        launched = true;
        Log.v(TAG,"End of StartActivity");

    }

    public void testHello() {
        assertTrue(true);
    }

    private int counter = 0;

    public void testSendMessage() {
        startActivity();
        Log.v(TAG,"testSendMessage");

        SystemMessenger.Listener listener = new SystemMessenger.Listener() {

            public boolean post(String name , Map data) {
                Log.v(TAG,"Listener::post");

                if (name.equals("testSendMessage")) {
                    counter++;
                    return true;
                }
                return false;
            }
        };

        SystemMessenger.addListener(listener);
        assertTrue(counter == 0);

        SystemMessenger.post("testSendMessage",null);

        assertTrue(counter == 1);

        SystemMessenger.removeListener(listener);

        SystemMessenger.post("testSendMessage",null);
        assertTrue(counter == 1);

    }

    private Queue<String> queue;

    public void testReentrant() {
        startActivity();
        queue = new LinkedList();

        Log.v(TAG,"testReentrant");
        final String messageName = "testReentrant";

        SystemMessenger.Listener listener = new SystemMessenger.Listener() {

            public boolean post(String name , Map data) {
                if (name.equals("ping")) {
                    counter++;
                    SystemMessenger.post("pong");
                    return true;
                }
                return false;
            }
        };

        SystemMessenger.addListener(listener);
        SystemMessenger.addListener(listener);

        assertTrue(counter == 0);

        SystemMessenger.post("ping",null);
        assertEquals(counter , 6);

        SystemMessenger.removeListener(listener);

    }



}
