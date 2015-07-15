package quickandroid.example;
import quickandroid.SystemDispatcher;

import java.util.Map;
import java.util.HashMap;
import org.qtproject.qt5.android.QtNative;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.BitmapDrawable;
import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.graphics.drawable.Drawable;
import android.util.Log;
import android.os.Handler;
import android.app.Activity;
import android.view.View;
import android.content.Context;

/* Custom QtActivity is not a must to develop Android application using Qt. It is just
   needed for using native API that need to use resource files.

   In this example, it will demonstrate how to use the notification system.
 */

public class ExampleActivity extends org.qtproject.qt5.android.bindings.QtActivity {

    static {

        SystemDispatcher.addListener(new SystemDispatcher.Listener() {

            NotificationManager m_notificationManager;
            Notification.Builder m_builder;

            private void notificationManagerNotify(Map data) {

                final Activity activity = QtNative.activity();
                final Map messageData = data;

                Runnable runnable = new Runnable () {
                    public void run() {
                        try {
                            String title = (String) messageData.get("title");

                            String message = (String) messageData.get("message");

                            if (m_notificationManager == null) {
                                m_notificationManager = (NotificationManager) activity.getSystemService(Context.NOTIFICATION_SERVICE);
                                m_builder = new Notification.Builder(activity);

                                // Small Icon is a must to make notification works.
                                // And that is why you need to inherit QtActivity
                                m_builder.setSmallIcon(R.drawable.icon);
                            }

                            Log.d("",String.format("notificationManagerNotify(%s)",message));

                            m_builder.setContentTitle(title);
                            m_builder.setContentText(message);
                            m_notificationManager.notify(1, m_builder.build());

                            // Test function. Remove it later.
                            SystemDispatcher.dispatch("notificationManagerNotifyFinished");
                        } catch (Exception e) {
                            Log.d("",e.getMessage());
                        }

                    };
                };
                activity.runOnUiThread(runnable);
            }

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
                        SystemDispatcher.dispatch("hapticFeedbackPerformFinished");
                    };
                };
                activity.runOnUiThread(runnable);
            }

            public void onDispatched(String name , Map data) {
                Log.d("","Listener::post");

                if (name.equals("notificationManagerNotify")) {
                    notificationManagerNotify(data);
                    return;
                } else if (name.equals("hapticFeedbackPerform")) {
                    hapticFeedbackPerform(data);
                    return;
                }

                return;
            }
        });

    }


}

