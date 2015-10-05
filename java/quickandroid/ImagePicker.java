package quickandroid;
import quickandroid.SystemDispatcher;
import org.qtproject.qt5.android.QtNative;
import android.content.Intent;
import android.util.Log;
import android.app.Activity;
import java.util.Map;
import android.net.Uri;
import java.util.HashMap;

public class ImagePicker {

    // Random
    public static final int PICK_IMAGE_ACTION = 0x245285a3;

    public static final String PICK_IMAGE_MESSAGE = "quickandroid.ImagePicker.pickImage";
    public static final String PICKED_IMAGE_MESSAGE = "quickandroid.ImagePicker.pickedImage";


    private static final String TAG = "ImagePicker";

    static {
        Log.d(TAG,"Register signal");

        SystemDispatcher.addListener(new SystemDispatcher.Listener() {
            public void onDispatched(String type , Map message) {
                Log.d(TAG,type);
                if (type.equals(PICK_IMAGE_MESSAGE)) {
                    pickImage(message);
                } else if (type.equals(SystemDispatcher.ACTIVITY_RESULT_MESSAGE)) {
                    onActivityResult(message);
                }
            }
        });
    }

    public static void init() {
        Log.d(TAG,"init()");

    }

    static void pickImage(Map message) {
        System.out.println("pickImage");

        Activity activity = org.qtproject.qt5.android.QtNative.activity();

        Intent i = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

        // >= API 18
//        i.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);
        activity.startActivityForResult(i, PICK_IMAGE_ACTION);
    }

    static private void onActivityResult(Map message) {
        int resultCode = (Integer) message.get("resultCode");
        if (resultCode != Activity.RESULT_OK)
            return;
        int requestCode = (Integer) message.get("requestCode");
        Intent data = (Intent) message.get("data");

        if (requestCode == PICK_IMAGE_ACTION) {
            Uri uri = data.getData();

            Log.d(TAG,"importMediaImage: " + uri);
            Log.d(TAG,"Data Type: " + data.getType());

            Map reply = new HashMap();
            reply.put("uri",uri.toString());
            SystemDispatcher.dispatch(PICKED_IMAGE_MESSAGE,reply);
        }
    }


}

