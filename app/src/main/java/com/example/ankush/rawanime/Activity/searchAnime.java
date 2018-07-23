package com.example.ankush.rawanime.Activity;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.fetch.FetchRecentlyUpdated;

public class searchAnime extends AppCompatActivity {

    String url="https://www4.gogoanimes.tv/search.html?keyword=";
    String searchText;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search_anime);
        Intent intent=getIntent();
        searchText=intent.getStringExtra("text");
        searchText=getProperSearchText(searchText);
        Log.d("searchText",searchText);



    }





    private String getProperSearchText(String text){

        return text.replace(" ","%20");

    }


    private class MyAsyncTask extends AsyncTask<Void,Void,Void> {

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
        protected Void doInBackground(Void... voids) {
            FetchRecentlyUpdated fetchAnimes=new FetchRecentlyUpdated() ;
            fetchAnimes.setList(mainPageUrl);
            list.clear();
            list.addAll(fetchAnimes.getList());
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
