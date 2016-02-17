package quickandroid.example;

import android.test.ActivityInstrumentationTestCase2;
import android.util.Log;
import quickandroid.SystemDispatcher;
import java.util.Map;
import android.content.Intent;
import android.test.ActivityTestCase;
import android.app.Instrumentation;
import android.app.Activity;
import java.util.Queue;
import java.util.LinkedList;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import quickandroid.QuickAndroidActivity;

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
public class ExampleActivityTest extends ActivityInstrumentationTestCase2<QuickAndroidActivity> {

    private static String TAG = "ActivityTest";

    public ExampleActivityTest() {
        super("quickandroid", QuickAndroidActivity.class);
    }

    private static boolean launched = false;
    private static Activity mActivity = null;

    private void startActivity() {
        if (launched)
            return;

        Instrumentation instrumentation = getInstrumentation();
        Intent intent = new Intent(getInstrumentation()
                .getTargetContext(), QuickAndroidActivity.class);
        intent.setFlags(intent.getFlags()  | Intent.FLAG_ACTIVITY_NEW_TASK);

        mActivity = instrumentation.startActivitySync(intent);
        launched = true;
        
        instrumentation.waitForIdleSync();
        sleep(5000);
    }

    private int counter = 0;

    public void testDispatch() {
        startActivity();

        SystemDispatcher.Listener listener = new SystemDispatcher.Listener() {

            public void onDispatched(String name , Map data) {
                Log.v(TAG,"Listener::onDispatched " + name);

                if (name.equals("testSendMessage")) {
                    counter++;
                }
            }
        };

        SystemDispatcher.addListener(listener);
        assertTrue(counter == 0);

        SystemDispatcher.dispatch("testSendMessage",null);

        assertEquals(counter , 1);

        SystemDispatcher.removeListener(listener);

        SystemDispatcher.dispatch("testSendMessage",null);
        assertTrue(counter == 1);

    }

    private List<String> messages ;

    public void testDispatchReentrant() {
        startActivity();
        Log.v(TAG,"testDispatchReentrant");
        messages = new ArrayList();

        final String messageName = "testReentrant";

        SystemDispatcher.Listener listener = new SystemDispatcher.Listener() {

            public void onDispatched(String name , Map data) {
                messages.add(name);
                if (name.equals("ping")) {
                    counter++;
                    SystemDispatcher.dispatch("pong");
                } else if (name.equals("poing")) {
                    counter++;
                }
                return;
            }
        };

        SystemDispatcher.addListener(listener);
        SystemDispatcher.addListener(listener);

        assertTrue(messages.size() == 0);

        SystemDispatcher.dispatch("ping",null);
        assertEquals(messages.size() , 6);
        assertTrue(messages.get(0).equals("ping"));
        assertTrue(messages.get(1).equals("ping"));
        assertTrue(messages.get(2).equals("pong"));
        assertTrue(messages.get(3).equals("pong"));
        assertTrue(messages.get(4).equals("pong"));
        assertTrue(messages.get(5).equals("pong"));


        SystemDispatcher.removeListener(listener);
        SystemDispatcher.removeListener(listener);
    }

    private static class Payload {
        public String name;
        public Map message;
    }


    private static Payload lastPayload;

    /** Verify the data convension function between C++ and Java */
    public void testDispatchTypes() {
        startActivity();
        
        Log.v(TAG,"testDispatchTypes");
        SystemDispatcher.Listener listener = new SystemDispatcher.Listener() {

            public void onDispatched(String type , Map message) {
                Log.v(TAG,"testDispatchTypes - onDispatched: " + type);

                if (!type.equals("Automater::response")) {
                    return;
                }

                Payload payload = new Payload();
                payload.name = type;
                payload.message = message;

                lastPayload = payload;
            }
        };

        SystemDispatcher.addListener(listener);

        Map message = new HashMap();
        message.put("field1","value1");
        message.put("field2",10);
        message.put("field3",true);
        message.put("field4",false);
      
        List field5 = new ArrayList(3);
        field5.add(23);
        field5.add(true);
        field5.add("stringValue");
        message.put("field5",field5);
        field5 = new ArrayList(10);

        Map field6 = new HashMap();
        field6.put("sfield1", "value1");
        field6.put("sfield2", 10);
        field6.put("sfield3", true);
        field6.put("sfield4", false);
        message.put("field6", field6);
 
        assertTrue(lastPayload == null);

        SystemDispatcher.dispatch("Automater::echo",message);
        sleep(500);

        assertTrue(lastPayload != null);
        assertTrue(lastPayload.message.containsKey("field1"));
        assertTrue(lastPayload.message.containsKey("field2"));
        assertTrue(lastPayload.message.containsKey("field3"));
        assertTrue(lastPayload.message.containsKey("field4"));
        assertTrue(lastPayload.message.containsKey("field5"));
        assertTrue(lastPayload.message.containsKey("field6"));

        String field1 = (String)  lastPayload.message.get("field1");
        assertTrue(field1.equals("value1"));

        int field2 = (int) (Integer) lastPayload.message.get("field2");
        assertEquals(field2,10);

        boolean field3 = (boolean)(Boolean) lastPayload.message.get("field3");
        assertEquals(field3,true);

        boolean field4 = (boolean)(Boolean) lastPayload.message.get("field4");
        assertEquals(field4,false);
  
        List list = (List) lastPayload.message.get("field5");
        assertEquals(list.size(),3);
        assertEquals(list.get(0), 23);
        assertEquals(list.get(1), true);
        assertTrue((((String) list.get(2)).equals("stringValue")));

        Map map = (Map) lastPayload.message.get("field6");
        assertTrue(map.containsKey("sfield1"));
        assertTrue(((String) map.get("sfield1")).equals("value1"));
        assertTrue(map.containsKey("sfield2"));
        assertEquals(map.get("sfield2"), 10);
        assertTrue(map.containsKey("sfield3"));
        assertTrue(map.containsKey("sfield4"));
        
        SystemDispatcher.removeListener(listener);
    }

    public void testOnActivityResult() {
        SystemDispatcher.Listener listener = new SystemDispatcher.Listener() {

            public void onDispatched(String name , Map message) {

                Payload payload = new Payload();
                payload.name = name;
                payload.message = message;

                lastPayload = payload;
            }
        };
        SystemDispatcher.addListener(listener);

        SystemDispatcher.onActivityResult(73, 99, null);
        sleep(500);

        assertTrue(lastPayload != null);
        assertEquals(SystemDispatcher.ACTIVITY_RESULT_MESSAGE, lastPayload.name);

        assertTrue(lastPayload.message.containsKey("requestCode"));
        assertTrue(lastPayload.message.containsKey("resultCode"));
        assertTrue(lastPayload.message.containsKey("data"));

        assertEquals((int) (Integer) lastPayload.message.get("requestCode"), 73);
        assertEquals((int) (Integer) lastPayload.message.get("resultCode") ,99);

        SystemDispatcher.removeListener(listener);

    }

    public void testHashTableOverflow() {
        ArrayList list = new ArrayList();

        int count = 600;

        for (int i = 0 ; i < count ; i++) {
            HashMap map = new HashMap();
            map.put("value1", 1);
            map.put("value2", true);
            map.put("value3", "value3");

            list.add(map);
        }

        HashMap message = new HashMap();
        message.put("list", list);

        SystemDispatcher.Listener listener = new SystemDispatcher.Listener() {

            public void onDispatched(String name , Map message) {

                if (!name.equals("Automater::response")) {
                    return;
                }
                Payload payload = new Payload();
                payload.name = name;
                payload.message = message;

                lastPayload = payload;
            }
        };

        SystemDispatcher.addListener(listener);
        SystemDispatcher.dispatch("Automater::echo", message);

        sleep(500);

        assertTrue(lastPayload != null);
        assertTrue(lastPayload.message.containsKey("list"));

        List retList = (List) lastPayload.message.get("list");

        assertEquals(retList.size() , count);

        SystemDispatcher.removeListener(listener);

    }

    private void sleep(int timeout) {
        try {
            Thread.sleep(timeout);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }        
    }



}
