package com.example.ankush.rawanime.adapters;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.example.ankush.rawanime.Activity.StreamVideo;
import com.example.ankush.rawanime.Activity.WatchDownload;
import com.example.ankush.rawanime.Activity.streamingServer;
import com.example.ankush.rawanime.R;
import com.gecdevelopers.scrapper.EpisodeModel;

import java.util.List;

public class SelectedAnimeAdapter  extends RecyclerView.Adapter<SelectedAnimeAdapter.ViewHolder> {

    List<EpisodeModel> items;
    Context context;

    public SelectedAnimeAdapter(List<EpisodeModel> items, Context context) {
        this.items = items;
        this.context = context;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v= LayoutInflater.from(context).inflate(R.layout.episode_items,parent,false);
        return new ViewHolder(v);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        String episodeName= items.get(position).getEpisode();
        holder.textView.setText(episodeName);
    }

    @Override
    public int getItemCount() {
        return items.size();
    }



    public class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        public TextView textView;
        public ViewHolder(View itemView) {
            super(itemView);
            textView=(TextView)itemView.findViewById(R.id.episodeTextView);
            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View v) {
            int p = getAdapterPosition();
            Toast.makeText(context,""+p,Toast.LENGTH_SHORT).show();
            Intent intent = new Intent(context, StreamVideo.class);
            intent.putExtra("url", items.get(p).getEpisodeUrl());
            context.startActivity(intent);
        }
    }


}