package quickandroid;
import quickandroid.SystemDispatcher;
import org.qtproject.qt5.android.QtNative;
import java.util.HashMap;
import android.content.Intent;

/** An alternative Activity class for Qt applicaiton.

  Remarks: It is not a must to use this class as the main activity.
 */

public class QuickAndroidActivity extends org.qtproject.qt5.android.bindings.QtActivity {

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        SystemDispatcher.onActivityResult(requestCode,resultCode,data);
    }

    protected void onResume() {
        super.onResume();
        SystemDispatcher.onActivityResume();
    }

}

