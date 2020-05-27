package kh.edu.rupp.fe.onlinestore.adapter;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import androidx.annotation.NonNull;
import androidx.viewpager.widget.PagerAdapter;

import kh.edu.rupp.fe.onlinestore.R;

public class SlideShowAdapter extends PagerAdapter {

    // Dataset
    private int[] imagePaths;

    public SlideShowAdapter(int[] imagePaths) {
        this.imagePaths = imagePaths;
    }

    @Override
    public int getCount() {
        return imagePaths.length;
    }

    @Override
    public boolean isViewFromObject(@NonNull View view, @NonNull Object object) {
        return view == object;
    }

    @NonNull
    @Override
    public Object instantiateItem(@NonNull ViewGroup container, int position) {

        /*
        // Create view from code

        // Create an ImageView object and set the image
        ImageView imgSlide = new ImageView(container.getContext());
        ViewGroup.LayoutParams layoutParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        imgSlide.setLayoutParams(layoutParams);
        int imagePath = imagePaths[position];
        imgSlide.setImageResource(imagePath);

        container.addView(imgSlide);

        return imgSlide;*/

        // Create view from inflating layout file
        // Inflate view from layout file
        LayoutInflater inflater = LayoutInflater.from(container.getContext());
        View itemView = inflater.inflate(R.layout.view_slide_show_item, container, false);

        // Reference to the ImageView and set the image
        ImageView imgSlide = itemView.findViewById(R.id.img_slide);
        int imagePath = imagePaths[position];
        imgSlide.setImageResource(imagePath);

        container.addView(itemView);

        return itemView;
    }

    @Override
    public void destroyItem(@NonNull ViewGroup container, int position, @NonNull Object object) {
        container.removeView((View) object);
    }
}
