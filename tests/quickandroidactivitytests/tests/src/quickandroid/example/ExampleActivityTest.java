package quickandroid.example;

import android.test.ActivityInstrumentationTestCase2;
import android.util.Log;
import quickandroid.SystemMessenger;
import java.util.Map;
import android.content.Intent;
import android.test.ActivityTestCase;
import android.app.Instrumentation;
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

    @Override
    protected void setUp() throws Exception {
           super.setUp();
    }

    public void testHello() {
        assertTrue(true);
    }

    private int counter = 0;

    public void testSendMessage() {

        Instrumentation instrumentation = getInstrumentation();
        Intent intent = new Intent(getInstrumentation()
                .getTargetContext(), ExampleActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        instrumentation.startActivitySync(intent);


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
