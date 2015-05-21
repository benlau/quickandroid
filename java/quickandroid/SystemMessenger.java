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
import android.util.Log;

public class SystemMessenger {

    public SystemMessenger() {
    }

    public static boolean post(String name) {
        Log.d("",String.format("post(%s)", name));
        final String messageName = name;

        Activity activity = QtNative.activity();
        Runnable runnable = new Runnable () {
            public void run() {
                invoke(messageName);
            };
        };

        activity.runOnUiThread(runnable);
        return false;
    }

    private static native void invoke(String name);


}
