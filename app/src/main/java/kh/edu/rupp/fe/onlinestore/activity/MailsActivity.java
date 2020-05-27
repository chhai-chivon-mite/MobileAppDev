package kh.edu.rupp.fe.onlinestore.activity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.Volley;
import com.google.gson.Gson;

import org.json.JSONArray;

import kh.edu.rupp.fe.onlinestore.model.Mail;
import kh.edu.rupp.fe.onlinestore.adapter.MailsAdapter;
import kh.edu.rupp.fe.onlinestore.R;

public class MailsActivity extends AppCompatActivity {

    private RecyclerView recyclerView;
    private ProgressBar progressBar;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_mails);

        // RecyclerView
        recyclerView = findViewById(R.id.recycler_view);

        // Progressbar
        progressBar = findViewById(R.id.progress_bar);

        // LayoutManager
        RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(this);    // Vertical
        // RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false);    // Horizontal
        // RecyclerView.LayoutManager layoutManager = new GridLayoutManager(this, 2);    // Grid

        // Load mails from server
        loadMails();

        recyclerView.setLayoutManager(layoutManager);
    }

    private void loadMails(){

        // Show progress bar and hide recycler view
        showLoading(true);

        // Initialize request queue
        RequestQueue requestQueue = Volley.newRequestQueue(this);

        // Initialize request
        String url = "http://10.0.2.2/rupp/index.php";
        JsonArrayRequest request = new JsonArrayRequest(url, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                // Hide progress bar and show recycler view
                showLoading(false);

                // Dataset
                /*
                // Deserialize json without using library
                Mail[] mails = new Mail[response.length()];
                for(int i=0; i<response.length(); i++){
                    try {
                        JSONObject mailJson = response.getJSONObject(i);
                        String sender = mailJson.getString("sender");
                        String subject = mailJson.getString("subject");
                        String body = mailJson.getString("body");
                        String imageUrl = mailJson.getString("imageUrl");

                        Mail mail = new Mail();
                        mail.setSender(sender);
                        mail.setSubject(subject);
                        mail.setBody(body);
                        mail.setImageUrl(imageUrl);

                        mails[i] = mail;
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }*/

                // Deserialize json using gson library
                Gson gson = new Gson();
                Mail[] mails = gson.fromJson(response.toString(), Mail[].class);

                MailsAdapter adapter = new MailsAdapter(mails);
                recyclerView.setAdapter(adapter);

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                // Hide progress bar and show recycler view
                showLoading(false);

                Toast.makeText(MailsActivity.this, "Load data error.", Toast.LENGTH_LONG).show();
                Log.d("iteapp", "Load data error: " + error.getMessage());
            }
        });

        // Add request to Queue
        requestQueue.add(request);

    }

    private void showLoading(boolean state){
        if(state) {
            progressBar.setVisibility(View.VISIBLE);
            recyclerView.setVisibility(View.INVISIBLE);
        } else {
            progressBar.setVisibility(View.INVISIBLE);
            recyclerView.setVisibility(View.VISIBLE);
        }
    }

}
