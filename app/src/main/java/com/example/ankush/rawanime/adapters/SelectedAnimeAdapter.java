package com.example.ankush.rawanime.adapters;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.models.AnimeModel;
import com.example.ankush.rawanime.models.EpisodeDataModel;

import java.util.List;

public class SelectedAnimeAdapter  extends RecyclerView.Adapter<SelectedAnimeAdapter.ViewHolder> {

    List<EpisodeDataModel> items;
    Context context;

    public SelectedAnimeAdapter(List<EpisodeDataModel> items, Context context) {
        this.items = items;
        this.context = context;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v= LayoutInflater.from(context).inflate(R.layout.episode_items,parent,false);
        return new SelectedAnimeAdapter.ViewHolder(v);
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



    public class ViewHolder extends RecyclerView.ViewHolder {

        public TextView textView;
        public ViewHolder(View itemView) {
            super(itemView);
            textView=(TextView)itemView.findViewById(R.id.episodeTextView);

        }
    }


}