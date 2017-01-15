package quickandroid;

import android.app.Activity;
import android.widget.Toast;

public class ToastRunnable implements Runnable {
    private Activity activity;
    private String text;
    private int duration;

    public ToastRunnable(Activity activity, String text, int duration) {
        this.activity = activity;
        this.text = text;
        this.duration = duration;
    }

    @Override
    public void run() {
        Toast.makeText(activity, text, duration).show();
    }
}

