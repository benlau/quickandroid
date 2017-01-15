package quickandroid;

import android.app.Activity;
import android.util.Log;
import java.util.Map;

import org.qtproject.qt5.android.QtNative;

public class Toast {
    public static final String TOAST_MESSAGE = "quickandroid.Toast.showToast";

    private static final String TAG = "quickandroid.Toast";

    static {
        SystemDispatcher.addListener(new SystemDispatcher.Listener() {
            public void onDispatched(String type, Map message) {
                if (type.equals(TOAST_MESSAGE)) {
                    showToast(message);
                }
            }
        });
    }

    static void showToast(Map message) {
        if (!message.containsKey("text")) {
            Log.d(TAG, "showToast: no text");
            return;
        }

        int duration = android.widget.Toast.LENGTH_SHORT;
        if (message.containsKey("longLength")) {
            Boolean isLong = (Boolean)message.get("longLength");
            if (isLong != null && isLong == true)
                duration = android.widget.Toast.LENGTH_LONG;
        }

        Activity activity = QtNative.activity();
        activity.runOnUiThread(new ToastRunnable(activity, (String)message.get("text"), duration));
    }
}

