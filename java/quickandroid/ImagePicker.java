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
import android.content.ContentValues;
import java.text.SimpleDateFormat;
import java.io.File;
import java.util.Date;
import android.os.Environment;
import android.os.Handler;

public class ImagePicker {

    // Random
    public static final int PICK_IMAGE_ACTION = 0x245285a3;
    public static final int TAKE_PHOTO_ACTION = 0x29fe8748;

    public static final String PICK_IMAGE_MESSAGE = "quickandroid.ImagePicker.pickImage";
    public static final String PICKED_IMAGE_MESSAGE = "quickandroid.ImagePicker.pickedImage";
    public static final String TAKE_PHOTO_MESSAGE = "quickandroid.ImagePicker.takePhoto";

    private static final String TAG = "quickandroid.ImagePicker";

    private static Uri mPhotoUri;
    private static Boolean broadcast = false;

    static {
        SystemDispatcher.addListener(new SystemDispatcher.Listener() {
            public void onDispatched(String type , Map message) {
                if (type.equals(PICK_IMAGE_MESSAGE)) {
                    pickImage(message);
                } else if (type.equals(TAKE_PHOTO_MESSAGE)) {
                    takePhoto(message);
                } else if (type.equals(SystemDispatcher.ACTIVITY_RESULT_MESSAGE)) {
                    onActivityResult(message);
                }
            }
        });
    }

    static void pickImage(Map message) {
        Activity activity = org.qtproject.qt5.android.QtNative.activity();

        Intent intent = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

        // >= API 18
//        i.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);
        activity.startActivityForResult(intent, PICK_IMAGE_ACTION);
    }

    static void takePhoto(Map message) {
        if (message.containsKey("broadcast")) {
            broadcast = (Boolean) message.get("broadcast");
        }

        String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH.mm.ss").format(new Date());
        File storageDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM);
        if(!storageDir.exists() && !storageDir.mkdir())
            return;

        File image = new File(storageDir.getAbsolutePath() + "/" + timeStamp + ".jpg");
        mPhotoUri = Uri.fromFile(image);

        Log.d(TAG,"takePhoto : " + mPhotoUri);

        Intent intent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
        intent.putExtra(MediaStore.EXTRA_OUTPUT, mPhotoUri);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET);
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        intent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);

        Activity activity = org.qtproject.qt5.android.QtNative.activity();
        activity.startActivityForResult(intent,TAKE_PHOTO_ACTION);
    }

    static private void onActivityResult(Map message) {       
        int resultCode = (Integer) message.get("resultCode");
        if (resultCode != Activity.RESULT_OK)
            return;
        int requestCode = (Integer) message.get("requestCode");
        Intent data = (Intent) message.get("data");

        if (requestCode == PICK_IMAGE_ACTION) {
            importImage(data);
        } else if (requestCode == TAKE_PHOTO_ACTION) {
            if (data == null) {
                importImageFromFileUri(mPhotoUri);
                if (broadcast)
                    broadcastToMediaScanner(mPhotoUri);
            } else {
                importImage(data);
            }
        }
    }

    static private void importImage(Intent data) {
        Uri uri = data.getData();

        Log.d(TAG,"importImage: uri:" + uri);
        Log.d(TAG,"importImage: type: " + data.getType());

        if (uri != null ) {
            if (uri.getScheme().equals("file")) {
                importImageFromFileUri(uri);
            } else {
                importImageFromContentUri(uri);
            }
        }

    }

    static private void importImageFromFileUri(Uri uri) {
        Map reply = new HashMap();
        reply.put("imageUrl",uri.toString());
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

        importImageFromFileUri(fileUri);
    }

    private static void broadcastToMediaScanner(Uri uri) {
        Intent mediaScanIntent = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
        mediaScanIntent.setData(uri);

        Activity activity = org.qtproject.qt5.android.QtNative.activity();
        activity.sendBroadcast(mediaScanIntent);
    }

}

