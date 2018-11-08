package com.example.ankush.rawanime.Activity;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.ProgressBar;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.adapters.RecyclerViewAdapter;

import com.gecdevelopers.scrapper.AnimeModel;
import com.gecdevelopers.scrapper.Scraper;

import java.util.ArrayList;
import java.util.List;

public class searchAnime extends AppCompatActivity {

    RecyclerView recyclerView;
    RecyclerViewAdapter adapter;
    List<AnimeModel> list;
    ProgressBar progressBar;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.anime_list);
        Intent intent=getIntent();
        String searchText =intent.getStringExtra("text");
        Log.d("searchText",searchText);
        list= new ArrayList<>();
        adapter= new RecyclerViewAdapter(list,this);
        recyclerView=findViewById(R.id.recycler_view);
        recyclerView.setHasFixedSize(true);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);
        progressBar=findViewById(R.id.progressBar);
        progressBar.setVisibility(View.VISIBLE);

        MyAsyncTask task= new MyAsyncTask();
        task.execute(searchText);

    }


    private class MyAsyncTask extends AsyncTask<String,Void,Void> {


        @Override
        protected Void doInBackground(String... searchText) {
            Scraper scrapper= new Scraper();
            scrapper.startSearching(searchText[0]);
            list.addAll(scrapper.getSearchedAnimeList());
            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);
            runOnUiThread(new Runnable() {

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
