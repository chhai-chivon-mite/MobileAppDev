package kh.edu.rupp.fe.onlinestore;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.util.Log;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_drawer);

        
    }



    @Override
    protected void onStart() {
        super.onStart();

        Log.d("abc", "[MainActivity]onStart");
    }

    @Override
    protected void onResume() {
        super.onResume();

        Log.d("abc", "[MainActivity]onResume");
    }

    @Override
    protected void onPause() {
        super.onPause();

        Log.d("abc", "[MainActivity]onPause");
    }

    @Override
    protected void onStop() {
        super.onStop();

        Log.d("abc", "[MainActivity]onStop");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        Log.d("abc", "[MainActivity]onDestroy");
    }

    @Override
    protected void onRestart() {
        super.onRestart();

        Log.d("abc", "[MainActivity]onRestart");
    }
}
