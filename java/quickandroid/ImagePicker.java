package quickandroid;
import org.qtproject.qt5.android.QtNative;
import android.content.Intent;
import android.util.Log;
import android.app.Activity;
import java.util.Map;
import android.net.Uri;
import java.util.HashMap;
import android.database.Cursor;
import android.provider.MediaStore;

import java.text.SimpleDateFormat;
import java.io.File;
import java.util.Date;
import android.os.Environment;
import android.content.ClipData;
import java.util.List;
import java.util.ArrayList;

public class ImagePicker {

    // Random
    public static final int PICK_IMAGE_ACTION = 0x245285a3;
    public static final int TAKE_PHOTO_ACTION = 0x29fe8748;

    public static final String PICK_IMAGE_MESSAGE = "quickandroid.ImagePicker.pickImage";
    public static final String TAKE_PHOTO_MESSAGE = "quickandroid.ImagePicker.takePhoto";
    public static final String CHOSEN_MESSAGE = "quickandroid.ImagePicker.chosen";

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
        Boolean multiple = false;
        Activity activity = org.qtproject.qt5.android.QtNative.activity();

        Intent intent = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);

        if (message.containsKey("multiple")) {
            multiple = (Boolean) message.get("multiple");
        }

        if (multiple) {
            intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);
        }

        // >= API 18
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
            // Android 4.x. data will be null.
            // Android 6.x. data is not null
            importImageFromFileUri(mPhotoUri);
            if (broadcast)
                broadcastToMediaScanner(mPhotoUri);
        }
    }

    static private void importImage(Intent data) {
        Uri uri = data.getData();

        Log.d(TAG,"importImage: uri:" + uri);
        Log.d(TAG,"importImage: type: " + data.getType());

        if (data.getClipData() != null) {
            importImageFromClipData(data);
        } else if (uri != null ) {
            if (uri.getScheme().equals("file")) {
                importImageFromFileUri(uri);
            } else {
                importImageFromContentUri(uri);
            }
        }

    }

    static private void importImageFromFileUri(Uri uri) {
        ArrayList<Uri> list = new ArrayList(1);
        list.add(uri);
        importImageFromFileUri(list);
    }

    static private void importImageFromFileUri(List uris) {
        Map reply = new HashMap();
        ArrayList<String> list = new ArrayList(uris.size());
        for (int i = 0 ; i < uris.size() ; i++) {
            list.add(uris.get(i).toString());
        }
        reply.put("imageUrls",list);
        SystemDispatcher.dispatch(CHOSEN_MESSAGE,reply);
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
        ArrayList<Uri> uris = new ArrayList(cursor.getCount());

        for (int i = 0 ; i < cursor.getCount(); i++) {
            int columnIndex;
            columnIndex = cursor.getColumnIndex(columns[0]);
            String path = cursor.getString(columnIndex);

            /*
            columnIndex = cursor.getColumnIndex(columns[1]);
            int orientation = cursor.getInt(columnIndex);
            */

            if (path == null) {
                Log.d(TAG,"importImageFromContentUri: The path of image is null. The image may not on the storage.");
                continue;
            }

            Uri fileUri = Uri.fromParts("file",path,"");
            uris.add(fileUri);

            Log.d(TAG,"importImageFromContentUri: " + fileUri.toString());
        }

        importImageFromFileUri(uris);
        cursor.close();



    }

    private static void importImageFromClipData(Intent data) {
        ClipData clipData = data.getClipData();

        Log.d(TAG,"importFromClipData");

        if (clipData.getItemCount() == 0)
            return;

        ArrayList<Uri> uris = new ArrayList(clipData.getItemCount());

        for (int i = 0 ; i < clipData.getItemCount() ; i++ ){
            Uri uri = clipData.getItemAt(i).getUri();
            uris.add(resolveUri(uri));
        }
        importImageFromFileUri(uris);
    }

    static private Uri resolveUri(Uri uri) {
        Activity activity = org.qtproject.qt5.android.QtNative.activity();

        String[] columns = { MediaStore.Images.Media.DATA, MediaStore.Images.ImageColumns.ORIENTATION};

        Cursor cursor = activity.getContentResolver().query(uri, columns, null, null, null);
        if (cursor == null) {
            Log.d(TAG,"Query failed");
            return Uri.parse("");
        }

        cursor.moveToFirst();
        int columnIndex;

        columnIndex = cursor.getColumnIndex(columns[0]);
        String path = cursor.getString(columnIndex);

//        columnIndex = cursor.getColumnIndex(columns[1]);
//        int orientation = cursor.getInt(columnIndex);
        cursor.close();
        return Uri.fromParts("file",path,"");
    }

    private static void broadcastToMediaScanner(Uri uri) {
        Intent mediaScanIntent = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
        mediaScanIntent.setData(uri);

        Activity activity = org.qtproject.qt5.android.QtNative.activity();
        activity.sendBroadcast(mediaScanIntent);
    }

}

