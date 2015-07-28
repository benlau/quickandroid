package quickandroid.example;
import quickandroid.SystemDispatcher;
import android.app.Notification;
import android.app.NotificationManager;
import android.util.Log;
import android.os.Handler;
import android.app.Activity;
import android.view.View;
import android.content.Context;
import java.util.Map;
import org.qtproject.qt5.android.QtNative;

public class ExampleService {

    static void start() {

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

                            m_builder.setContentTitle(title);
                            m_builder.setContentText(message);
                            m_notificationManager.notify(1, m_builder.build());

                            // Test function. Remove it later.
                            SystemDispatcher.dispatch("Notifier.notifyFinished");
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

                if (name.equals("Notifier.notify")) {
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

