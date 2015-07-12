package quickandroid.activitytests;

import android.test.ActivityInstrumentationTestCase2;
import android.util.Log;

/**
 * This is a simple framework for a test of an Application.  See
 * {@link android.test.ApplicationTestCase ApplicationTestCase} for more information on
 * how to write and extend Application tests.
 * <p/>
 * To run this test, you can type:
 * adb shell am instrument -w \
 * -e class quickandroid.activitytests.UnitTestsActivityTest \
 * quickandroid.activitytests.tests/android.test.InstrumentationTestRunner
 */
public class UnitTestsActivityTest extends ActivityInstrumentationTestCase2<UnitTestsActivity> {

    static private String TAG = "QA";

    public UnitTestsActivityTest() {
        super("quickandroid.activitytests", UnitTestsActivity.class);
    }


    @Override
    protected void setUp() throws Exception {
      super.setUp();
      Log.d(TAG,"Setup");
    }

    public void testHello() {
        assertTrue(true);
    }


}
