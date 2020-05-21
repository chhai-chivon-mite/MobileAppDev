package kh.edu.rupp.fe.onlinestore;

import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager.widget.ViewPager;

public class SlideShowActivity extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_slide_show);

        // Reference to ViewPager
        ViewPager viewPager = findViewById(R.id.view_pager);

        // Adapter
        int[] imagePaths = new int[]{R.drawable.img_fe_logo, R.drawable.img_ite_banner, R.drawable.img_bio_banner, R.drawable.img_telecom_banner};
        SlideShowAdapter adapter = new SlideShowAdapter(imagePaths);

        // Set adapter to ViewPage
        viewPager.setAdapter(adapter);
    }
}
