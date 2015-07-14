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
import java.lang.Thread;
import android.util.Log;
import android.os.Handler;
import android.os.Looper;
import java.util.concurrent.Semaphore;

public class SystemMessenger {

    public interface Listener {
        /** Every messages posted on SystemMessenger will trigger this function.

            @return true if the message is handled. Otherwise, it should be false.
         */
        public boolean post(String name , Map data);
    }

    private static class Pair {
        public String name;
        public Map message;
    }

    private static String TAG = "QuickAndroid";

    private static Semaphore mutex = new Semaphore(1);

    private static Queue<Pair> queue = new LinkedList();

    private static List<Listener> listeners = new ArrayList<Listener>();

    private static boolean dispatching = false;

    /** Post a message with argument. It will trigger listener's post() method.

       @remarks: The function may not be running from the UI thread. It is listener's duty to handle multiple threading issue.
     */

    public static boolean post(String name) {
        return post(name,new HashMap());
    }

    /** Post a message. It will trigger listener's post() method.

        @threadsafe
       @remarks: The function may not be running from the UI thread. It is listener's duty to handle multiple threading issue.
     */
    public static boolean post(String name,Map data) {
        boolean res = false;

        try {
            Pair pair;

            mutex.acquire();

            if (dispatching) {
                pair = new Pair();
                pair.name = name;
                pair.message = data;
                queue.add(pair);
                mutex.release();
                return false;
            }

            dispatching = true;
            printMap(data);
            mutex.release();

            emit(name,data); // Emit

            mutex.acquire(); // Process queued message
            while (queue.size() > 0 ) {
                pair = queue.poll();
                mutex.release();

                emit(pair.name,pair.message);

                mutex.acquire();
            }
            dispatching = false;
            mutex.release();

        } catch (Exception e) {
            String err = (e.getMessage() == null) ? "post() failed" : e.getMessage();
            //Log.d(TAG,e.getCause().getMessage());
            Log.e(TAG,"exception",e);
        }

        return res;
    }

    public static void addListener(Listener listener ) {
        listeners.add(listener);
    }

    public static void removeListener(Listener listener ) {
        listeners.remove(listener);
    }

    private static native void invoke(String name,Map data);

    private static void emit(String name,Map data) {
        final String messageName = name;
        final Map messageData = data;

        /*
        if ( Looper.getMainLooper().getThread() == Thread.currentThread() ) {
            // It is UI thread
            Handler handler = new Handler();
            handler.postDelayed(new Runnable() {
                 public void run() {
                     Log.d(TAG,"Invoke by handler");
                     invoke(messageName,messageData);
                 }
            }, 0);

        } else {
            Activity activity = QtNative.activity();

            Runnable runnable = new Runnable () {
                public void run() {
                    Log.d(TAG,"Invoke by runOnUiThread");
                    invoke(messageName,messageData);
                };
            };
            activity.runOnUiThread(runnable);
        }
        */

        for (int i = 0 ; i < listeners.size() ; i++ ) {
            Listener listener = listeners.get(i);
            try {
                listener.post(name,data);
            } catch (Exception e) {
                Log.d(TAG,e.getMessage());
            }
        }

        invoke(name,data);
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
}
