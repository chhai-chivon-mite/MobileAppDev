package kh.edu.rupp.fe.onlinestore;

import android.app.Application;

import com.facebook.drawee.backends.pipeline.Fresco;
import com.google.android.libraries.places.api.Places;

public class MyApp extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        // Initialize Fresco library
        Fresco.initialize(this);

        // Initialize Place SDK
        Places.initialize(this, getString(R.string.gmap_api_key));
    }

}
