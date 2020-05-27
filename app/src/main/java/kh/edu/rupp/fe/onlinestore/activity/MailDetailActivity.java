package kh.edu.rupp.fe.onlinestore.activity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.facebook.drawee.view.SimpleDraweeView;
import com.google.gson.Gson;

import kh.edu.rupp.fe.onlinestore.R;
import kh.edu.rupp.fe.onlinestore.model.Mail;

public class MailDetailActivity extends AppCompatActivity {

    public static final String EXTRA_MAIL = "mail";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_mail_detail);

        Intent intent = getIntent();
        String mailJson = intent.getStringExtra(EXTRA_MAIL);

        // Deserialize json string to mail object
        Gson gson = new Gson();
        Mail mail = gson.fromJson(mailJson, Mail.class);

        // Bind data
        TextView txtSender = findViewById(R.id.txt_sender);
        TextView txtSubject = findViewById(R.id.txt_subject);
        TextView txtBody = findViewById(R.id.txt_body);
        SimpleDraweeView imgMail = findViewById(R.id.img_mail);

        txtSender.setText("Sender: " + mail.getSender());
        txtSubject.setText("Subject: " + mail.getSubject());
        txtBody.setText("Body: " + mail.getBody());
        imgMail.setImageURI(mail.getImageUrl());

    }
}
