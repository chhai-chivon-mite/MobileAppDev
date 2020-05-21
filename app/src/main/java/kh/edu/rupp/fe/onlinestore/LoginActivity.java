package kh.edu.rupp.fe.onlinestore;

import android.content.Intent;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.RecyclerView;

import org.w3c.dom.Text;

public class LoginActivity extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_login);

        Log.d("abc", "[LoginActivity]onCreate");
    }



    @Override
    protected void onStart() {
        super.onStart();

        Log.d("abc", "[LoginActivity]onStart");
    }

    @Override
    protected void onResume() {
        super.onResume();

        Log.d("abc", "[LoginActivity]onResume");
    }

    @Override
    protected void onPause() {
        super.onPause();

        Log.d("abc", "[LoginActivity]onPause");
    }

    @Override
    protected void onStop() {
        super.onStop();

        Log.d("abc", "[LoginActivity]onStop");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        Log.d("abc", "[LoginActivity]onDestroy");
    }

    @Override
    protected void onRestart() {
        super.onRestart();

        Log.d("abc", "[LoginActivity]onRestart");
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent intent) {
        super.onActivityResult(requestCode, resultCode, intent);

        if(requestCode == 5){
            if(resultCode == RESULT_OK){
                String data = intent.getStringExtra("data");

                TextView txtLoginTitle = findViewById(R.id.txt_login_title);
                txtLoginTitle.setText(data);

            }
        }
    }

    // Event listener methods
    public void onLoginClick(View view){
        EditText etxtUsername = findViewById(R.id.etxt_username);
        String username = etxtUsername.getText().toString();

        Intent mainActivityIntent = new Intent(this, MainActivity.class);
        mainActivityIntent.putExtra("username", username);
        //startActivity(mainActivityIntent);
        startActivityForResult(mainActivityIntent, 5);
    }



}
