package kh.edu.rupp.fe.onlinestore;

import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class MailsActivity extends AppCompatActivity {

    private RecyclerView recyclerView;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_mails);

        // RecyclerView
        recyclerView = findViewById(R.id.recycler_view);

        // LayoutManager
        RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(this);    // Vertical
        // RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false);    // Horizontal
        // RecyclerView.LayoutManager layoutManager = new GridLayoutManager(this, 2);    // Grid

        // Load mails from server
        loadMails();

        recyclerView.setLayoutManager(layoutManager);
    }

    private void loadMails(){

        // Initialize request queue
        RequestQueue requestQueue = Volley.newRequestQueue(this);

        // Initialize request
        String url = "http://10.0.2.2/rupp/index.php";
        JsonArrayRequest request = new JsonArrayRequest(url, new Response.Listener<JSONArray>() {
            @Override
            public void onResponse(JSONArray response) {
                // Dataset
                Mail[] mails = new Mail[response.length()];
                for(int i=0; i<response.length(); i++){
                    try {
                        JSONObject mailJson = response.getJSONObject(i);
                        String sender = mailJson.getString("sender");
                        String subject = mailJson.getString("subject");
                        String body = mailJson.getString("body");

                        Mail mail = new Mail();
                        mail.setSender(sender);
                        mail.setSubject(subject);
                        mail.setBody(body);

                        mails[i] = mail;
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }

                MailsAdapter adapter = new MailsAdapter(mails);
                recyclerView.setAdapter(adapter);

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Toast.makeText(MailsActivity.this, "Load data error.", Toast.LENGTH_LONG).show();
                Log.d("iteapp", "Load data error: " + error.getMessage());
            }
        });

        // Add request to Queue
        requestQueue.add(request);

    }

}
