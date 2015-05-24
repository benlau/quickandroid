// Author:  Ben Lau (https://github.com/benlau)
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
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.ArrayList;
import android.util.Log;
import android.os.Handler;
import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;

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

    static {

        addListener(new Listener() {

            private void hapticFeedbackPerform(Map data) {

                final Activity activity = QtNative.activity();
                final Map messageData = data;
                Runnable runnable = new Runnable () {
                    public void run() {
                        int feedbackConstant = (Integer) messageData.get("feedbackConstant");
                        int flags = (Integer) messageData.get("flags");

                        Log.d("",String.format("hapticFeedbackPerform(%d,%d)",feedbackConstant,flags));

                        View rootView = activity.getWindow().getDecorView().getRootView();
                        rootView.performHapticFeedback(feedbackConstant, flags);

                        // Test function. Remove it later.
                        SystemMessenger.post("hapticFeedbackPerformFinished" , new HashMap());
                    };
                };
                activity.runOnUiThread(runnable);
            }


            NotificationManager m_notificationManager;
            Notification.Builder m_builder;

            private void notificationManagerNotify(Map data) {

                final Activity activity = QtNative.activity();
                final Map messageData = data;

                Runnable runnable = new Runnable () {
                    public void run() {
                        String title = (String) messageData.get("title");

                        String message = (String) messageData.get("message");

                        if (m_notificationManager == null)
                            m_notificationManager = (NotificationManager) activity.getSystemService(Context.NOTIFICATION_SERVICE);

                        Log.d("",String.format("notificationManagerNotify(%s)",message));

                        if (m_builder == null) {
                            m_builder = new Notification.Builder(activity);
                        }

                        m_builder.setContentTitle(title);
                        m_builder.setContentText(message);
                        m_notificationManager.notify(1, m_builder.build());

                        // Test function. Remove it later.
                        SystemMessenger.post("notificationManagerNotifyFinished" , new HashMap());
                    };
                };
                activity.runOnUiThread(runnable);
            }


            public boolean post(String name , Map data) {
                Log.d("","Listener::post");

                if (name.equals("hapticFeedbackPerform")) {
                    hapticFeedbackPerform(data);
                    return true;
                } else if (name.equals("notificationManagerNotify")) {
                    notificationManagerNotify(data);
                    return true;
                }

                return false;
            }
        });

    }


}
