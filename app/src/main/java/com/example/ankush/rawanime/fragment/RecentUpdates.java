package com.example.ankush.rawanime.fragment;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ProgressBar;
import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.adapters.RecyclerViewAdapter;
import com.gecdevelopers.scrapper.AnimeModel;
import com.gecdevelopers.scrapper.Scrapper;

import java.util.ArrayList;
import java.util.List;

public class RecentUpdates extends Fragment{


    RecyclerView recyclerView;
    RecyclerViewAdapter adapter;
    List<AnimeModel> list;
    ProgressBar progressBar;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.anime_list,container,false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        list= new ArrayList<>();
        adapter= new RecyclerViewAdapter(list,getActivity());
        recyclerView=view.findViewById(R.id.recycler_view);
        recyclerView.setHasFixedSize(true);
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        recyclerView.setAdapter(adapter);
        progressBar=view.findViewById(R.id.progressBar);
        progressBar.setVisibility(View.VISIBLE);


        MyAsyncTask task= new MyAsyncTask();
        task.execute();
    }



    //asynsc task
    private class MyAsyncTask extends AsyncTask<Void,Void,Void> {
        @Override
        protected Void doInBackground(Void... voids) {

            //TODO Scrapper is changed to scraper after updating thwe library
            Scrapper scraper= new Scrapper();
            scraper.scrapeForRecentAnimeList();
            list.addAll(scraper.getRecentAnimeList());

            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);
           getActivity().runOnUiThread(new Runnable() {

                @Override
                public void run() {

                    // Stuff that updates the UI
                    progressBar.setVisibility(View.GONE);
                    adapter.notifyDataSetChanged();

                }
            });

        }
    }

}
