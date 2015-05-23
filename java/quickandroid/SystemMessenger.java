package quickandroid;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import android.content.Context;
import android.app.Activity;
import org.qtproject.qt5.android.QtNative;
import java.lang.String;
import java.util.Map;
import java.util.List;
import java.util.Set;
import java.util.ArrayList;
import android.util.Log;
import android.os.Handler;

interface Listener {
    /** Every messages posted on SystemMessenger will trigger this function.

        @return true if the message is handled. Otherwise, it should be false.
     */
    public boolean post(String name , Map data);
}

public class SystemMessenger {

    private static List<Listener> listeners = new ArrayList<Listener>();

    /** Post a message. It will trigger listener's post() method.

       @remarks: The function may not be running from the UI thread. It is listener's duty to handle multiple threading issue.
     */
    public static boolean post(String name,Map data) {
        boolean res = false;

        try {

            printMap(data);

            for (int i = 0 ; i < listeners.size() ; i++ ) {
                Listener listener = listeners.get(i);
                res |= listener.post(name,data);
            }

            final String messageName = name;
            final Map messageData = data;


            Activity activity = QtNative.activity();
            Runnable runnable = new Runnable () {
                public void run() {
                    Log.d("","Invoke");
                    invoke(messageName,messageData);
                };
            };
            activity.runOnUiThread(runnable);

            /*
            Handler handler = new Handler();
            handler.postDelayed(new Runnable() {
                 public void run() {
                     Log.d("","Invoke");
                     invoke(messageName,messageData);
                 }
            }, 0);
            */

        } catch (Exception e) {
            System.out.println(e.getMessage());

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


    private static void printMap(Map data) {
        for (Map.Entry entry : (Set<Map.Entry>) data.entrySet()) {
            String key = (String) entry.getKey();
            Object value = entry.getValue();
            if (value == null)
                continue;

            if (value instanceof String) {
                String stringValue = (String) value;
                Log.d("",String.format("%s : %s",key,stringValue));
            } else if (value instanceof Integer) {
                int intValue = (Integer) value;
                Log.d("",String.format("%s : %d",key,intValue));
            } else {
                Log.d("",String.format("%s : [%s]",value.getClass().getName()));
            }
        }

    }


}
