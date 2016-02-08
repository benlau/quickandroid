// Author:  Ben Lau (https://github.com/benlau)
package quickandroid;
import android.app.Activity;
import org.qtproject.qt5.android.QtNative;
import java.lang.String;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.ArrayList;
import java.util.Queue;
import java.util.LinkedList;
import java.lang.ClassLoader;
import java.lang.reflect.Method;
import java.lang.Thread;
import android.util.Log;
import android.os.Handler;
import android.os.Looper;
import android.content.Intent;
import java.util.concurrent.Semaphore;
import java.io.StringWriter;
import java.io.PrintWriter;

public class SystemDispatcher {

    public interface Listener {
        /** Every messages posted on SystemMessenger will trigger this function.

            @return true if the message is handled. Otherwise, it should be false.
         */
        public void onDispatched(String type , Map message);
    }

    /**
      @threadsafe
      @remarks: The function may not be running from the UI thread. It is listener's duty to handle multiple threading issue.
     */

    public static void dispatch(String name) {
        dispatch(name,null);
    }

    /** Dispatch a message.
       @threadsafe
       @remarks: The function may not be running from the UI thread. It is listener's duty to handle multiple threading issue.
     */
    public static void dispatch(String type,Map message) {
        try {

            Payload payload;

            mutex.acquire();

            if (dispatching) {
                payload = new Payload();
                payload.type = type;
                payload.message = message;
                queue.add(payload);
                mutex.release();
                return;
            }

            dispatching = true;
            mutex.release();

            emit(type,message); // Emit

            mutex.acquire(); // Process queued message

            while (queue.size() > 0 ) {
                payload = queue.poll();
                mutex.release();

                emit(payload.type,payload.message);

                mutex.acquire();
            }
            dispatching = false;
            mutex.release();

        } catch (Exception e) {
            Log.e(TAG,"exception",e);
        }
    }

    public static void addListener(Listener listener ) {
        try {
            mutex.acquire();
            listeners.add(listener);
            mutex.release();
        } catch (Exception e) {
            Log.e(TAG,"exception",e);
        }

    }

    public static void removeListener(Listener listener ) {
        try {
            mutex.acquire();
            listeners.remove(listener);
            mutex.release();
        } catch (Exception e) {
            Log.e(TAG,"exception",e);
        }
    }

    public static String ACTIVITY_RESUME_MESSAGE = "quickandroid.Activity.onResume";

    public static String ACTIVITY_RESULT_MESSAGE = "quickandroid.Activity.onActivityResult";

    public static String SYSTEM_DISPATCHER_LOAD_CLASS_MESSAGE = "quickandroid.SystemDispatcher.loadClass";

    /** A helper function to dispatch a massage when onResume is invoked in the Activity class
     */

    public static void onActivityResume() {
        dispatch(ACTIVITY_RESUME_MESSAGE);
    }

    /** A helper function to dispatch a message based on the input argument fron Activity.onActivityResult
     */
    public static void onActivityResult (int requestCode, int resultCode, Intent data) {
        Map message = new HashMap();

        message.put("requestCode",requestCode);
        message.put("resultCode",resultCode);
        message.put("data",data);

        dispatch(ACTIVITY_RESULT_MESSAGE,message);
    }

    private static class Payload {
        public String type;
        public Map message;
    }

    private static String TAG = "QuickAndroid";

    private static final Semaphore mutex = new Semaphore(1);

    private static Queue<Payload> queue = new LinkedList();

    private static List<Listener> listeners = new ArrayList<Listener>();

    private static boolean dispatching = false;

    private static native void jniEmit(String name,Map message);

    /** Emit onDispatched signal to registered listenter
     */
    private static void emit(String name,Map message) {
        for (int i = 0 ; i < listeners.size() ; i++ ) {
            Listener listener = listeners.get(i);
            try {
                listener.onDispatched(name,message);
            } catch (Exception e) {
                Log.d(TAG, Log.getStackTraceString(e));
            }
        }

        jniEmit(name,message);
    }

    private static void printMap(Map data) {
        if (data == null)
            return;
        try {
            for (Map.Entry entry : (Set<Map.Entry>) data.entrySet()) {
                String key = (String) entry.getKey();
                Object value = entry.getValue();
                if (value == null)
                    continue;

                if (value instanceof String) {
                    String stringValue = (String) value;
                    Log.d(TAG,String.format("%s : %s",key,stringValue));
                } else if (value instanceof Integer) {
                    int intValue = (Integer) value;
                    Log.d(TAG,String.format("%s : %d",key,intValue));
                } else if (value instanceof Boolean) {
                    Boolean booleanValue = (Boolean) value;
                    Log.d(TAG,String.format("%s : %b",key,booleanValue));
                } else {
                    Log.d(TAG,String.format("%s : Non-supported data type[%s] is passed",key,value.getClass().getName()));
                }
            }
        } catch (Exception e) {
            Log.d(TAG,e.getMessage());
        }

    }

    public static void loadClass(String className) {
        try {
            ClassLoader classLoader = SystemDispatcher.class.getClassLoader();
            Class aClass = Class.forName(className,true,classLoader);
//            Log.d(TAG,"Class Loaded: " + className);
        } catch (ClassNotFoundException e) {
            Log.e(TAG,"Failed to load class: " + className);
            e.printStackTrace();
        }
   }


   public static void init() {
       SystemDispatcher.addListener(new SystemDispatcher.Listener() {
           public void onDispatched(String type , Map message) {
//               Log.d(TAG,String.format("%s %b",type ,type.equals(SYSTEM_DISPATCHER_LOAD_CLASS_MESSAGE)));

               if (type.equals(SYSTEM_DISPATCHER_LOAD_CLASS_MESSAGE)) {
                   String className = (String) message.get("className");
                   loadClass(className);
               }
           }
       });

   }

}
