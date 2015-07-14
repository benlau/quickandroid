package quickandroid.example;

import android.test.ActivityInstrumentationTestCase2;
import android.util.Log;
import quickandroid.SystemMessenger;
import java.util.Map;

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

    public void testHello() {
        Log.v(TAG,"Hello2");
        assertTrue(true);
    }

    private int counter = 0;

    public void testSendMessage() {
        Log.v(TAG,"testSendMessage");
        Log.v(TAG,"testSendMessage2");

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


}
