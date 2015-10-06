package quickandroid;
import quickandroid.SystemDispatcher;
import org.qtproject.qt5.android.QtNative;
import android.content.Intent;
import android.util.Log;
import android.app.Activity;
import java.util.Map;
import android.net.Uri;
import java.util.HashMap;
import android.database.Cursor;
import android.provider.MediaStore;
import android.provider.MediaStore.Images;

public class ImagePicker {

    // Random
    public static final int PICK_IMAGE_ACTION = 0x245285a3;

    public static final String PICK_IMAGE_MESSAGE = "quickandroid.ImagePicker.pickImage";
    public static final String PICKED_IMAGE_MESSAGE = "quickandroid.ImagePicker.pickedImage";


    private static final String TAG = "quickandroid.ImagePicker";

    static {
        SystemDispatcher.addListener(new SystemDispatcher.Listener() {
            public void onDispatched(String type , Map message) {
                if (type.equals(PICK_IMAGE_MESSAGE)) {
                    pickImage(message);
                } else if (type.equals(SystemDispatcher.ACTIVITY_RESULT_MESSAGE)) {
                    onActivityResult(message);
                }
            }
        });
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
            importImage(data);
        }
    }

    static private void importImage(Intent data) {
        Uri uri = data.getData();

        Log.d(TAG,"importMediaImage: " + uri);
        Log.d(TAG,"Data Type: " + data.getType());

        if (uri != null ) {
            if (uri.getScheme().equals("file")) {
                importImageFromPath(uri.getPath());
            } else {
                importImageFromContentUri(uri);
            }
        }

    }

    static private void importImageFromPath(String uri) {
        Map reply = new HashMap();
        reply.put("imageUrl",uri);
        SystemDispatcher.dispatch(PICKED_IMAGE_MESSAGE,reply);
    }

    static private void importImageFromContentUri(Uri uri) {
        Activity activity = org.qtproject.qt5.android.QtNative.activity();

        String[] columns = { MediaStore.Images.Media.DATA, MediaStore.Images.ImageColumns.ORIENTATION };

        Cursor cursor = activity.getContentResolver().query(uri, columns, null, null, null);
        if (cursor == null) {
            Log.d(TAG,"importImageFromContentUri: Query failed");
            return;
        }

        cursor.moveToFirst();
        int columnIndex;

        columnIndex = cursor.getColumnIndex(columns[0]);
        String path = cursor.getString(columnIndex);

        columnIndex = cursor.getColumnIndex(columns[1]);
        int orientation = cursor.getInt(columnIndex);
        cursor.close();

        if (path == null) {
            Log.d(TAG,"importImageFromContentUri: The path of image is null. The image may not on the storage.");
            return;
        }

        Uri fileUri = Uri.fromParts("file",path,"");

        importImageFromPath(fileUri.toString());
    }




}

