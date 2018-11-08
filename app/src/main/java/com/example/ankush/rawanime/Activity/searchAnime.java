package com.example.ankush.rawanime.Activity;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.ProgressBar;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.adapters.RecyclerViewAdapter;
import com.example.ankush.rawanime.fetch.FetchRecentlyUpdated;
import com.example.ankush.rawanime.fetch.FetchSearchedAnime;
import com.example.ankush.rawanime.fragment.RecentUpdates;
import com.example.ankush.rawanime.models.AnimeModel;

import java.util.ArrayList;
import java.util.List;

public class searchAnime extends AppCompatActivity {

    String url="https://www4.gogoanime.se/search.html?keyword=";
    String searchText;
    RecyclerView recyclerView;
    RecyclerViewAdapter adapter;
    List<AnimeModel> list;
    ProgressBar progressBar;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.anime_list);
        Intent intent=getIntent();
        searchText=intent.getStringExtra("text");
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
        task.execute(url+getProperSearchText(searchText));

    }



    @NonNull
    private String getProperSearchText(String text){

        String[] s=text.split("\\s");
        String tmp="";
        for(String temp:s){
            if(tmp.length()>0)
            tmp=tmp + "+" +temp;
            else
                tmp=temp;
        }
        return tmp;
        //return text.replace("\\s","\\s+");

    }


    private class MyAsyncTask extends AsyncTask<String,Void,Void> {

        @Override
        protected void onProgressUpdate(Void... values) {
            super.onProgressUpdate(values);
            //since async works on different thread it cannot update the ui so we need to run the updating task on UI thread

            runOnUiThread(new Runnable() {

                @Override
                public void run() {
                    progressBar.setVisibility(View.GONE);
                    // Stuff that updates the UI
                    adapter.notifyDataSetChanged();

                }
            });
        }

        @Override
        protected Void doInBackground(String... url) {

            FetchSearchedAnime fetchSearchedAnime= new FetchSearchedAnime();
            fetchSearchedAnime.setList(url[0]);
            list.clear();
            list.addAll(fetchSearchedAnime.getList());
            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);
            runOnUiThread(new Runnable() {

                @Override
                public void run() {
                    progressBar.setVisibility(View.GONE);
                    // Stuff that updates the UI
                    adapter.notifyDataSetChanged();

                }
            });

        }
    }


}
