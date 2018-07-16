package com.example.ankush.rawanime.adapters;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.example.ankush.rawanime.Activity.AnimeSelected;
import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.models.AnimeModel;

import java.util.List;

public class RecyclerViewAdapter extends RecyclerView.Adapter<RecyclerViewAdapter.ViewHolder> {

    List<AnimeModel> items;
    Context context;

    public RecyclerViewAdapter(List<AnimeModel> items, Context context) {
        this.items = items;
        this.context = context;
    }


    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
       View v= LayoutInflater.from(context).inflate(R.layout.recycler_view_items,parent,false);
        return new ViewHolder(v);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {

     AnimeModel data= items.get(position);
     holder.titles.setText(data.getTitle());
     holder.episode.setText(data.getEpisode());
        Glide.with(context)
                .load(data.getImgUrl())
                .into(holder.imageView);
    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    public class ViewHolder extends  RecyclerView.ViewHolder implements View.OnClickListener{

        public TextView titles;
        public TextView episode;
        public ImageView imageView;

        public ViewHolder(View itemView) {
            super(itemView);

            titles=(TextView) itemView.findViewById(R.id.title);
            episode=(TextView) itemView.findViewById(R.id.episode);
            imageView=(ImageView)itemView.findViewById(R.id.image_view);
            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View v) {
            int p = getAdapterPosition();
            Intent intent = new Intent(context, AnimeSelected.class);
            intent.putExtra("url", items.get(p).getNextPageUrl());
            context.startActivity(intent);
        }
    }


}
