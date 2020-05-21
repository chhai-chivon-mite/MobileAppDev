package kh.edu.rupp.fe.onlinestore;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

public class MailsAdapter extends RecyclerView.Adapter<MailsAdapter.MailViewHolder> {

    // Dataset
    private Mail[] mails;

    public MailsAdapter(Mail[] mails) {
        this.mails = mails;
    }

    @NonNull
    @Override
    public MailViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(parent.getContext());
        View itemView = inflater.inflate(R.layout.view_holder_mail, parent, false);
        MailViewHolder viewHolder = new MailViewHolder(itemView);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull MailViewHolder holder, int position) {
        Mail mail = mails[position];
        holder.txtSender.setText(mail.getSender());
        holder.txtSubject.setText(mail.getSubject());
        holder.txtBody.setText(mail.getBody());
        holder.txtDate.setText(mail.getDate() + "");
        if(mail.isFavorite()){
            holder.imgFavorite.setImageResource(R.drawable.ic_favorite_on);
        } else {
            holder.imgFavorite.setImageResource(R.drawable.ic_favorite_off);
        }
    }

    @Override
    public int getItemCount() {
        return mails.length;
    }


    // ViewHolder
    static class MailViewHolder extends RecyclerView.ViewHolder {

        private TextView txtSender;
        private TextView txtSubject;
        private TextView txtBody;
        private TextView txtDate;
        private ImageView imgFavorite;

        public MailViewHolder(@NonNull View itemView) {
            super(itemView);

            txtSender = itemView.findViewById(R.id.txt_sender);
            txtSubject = itemView.findViewById(R.id.txt_subject);
            txtBody = itemView.findViewById(R.id.txt_body);
            txtDate = itemView.findViewById(R.id.txt_date);
            imgFavorite = itemView.findViewById(R.id.img_favorite);
        }

    }

}
