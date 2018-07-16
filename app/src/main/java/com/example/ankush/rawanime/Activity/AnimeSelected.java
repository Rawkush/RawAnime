package com.example.ankush.rawanime.Activity;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Parcelable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.models.AnimeModel;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.List;

public class AnimeSelected extends AppCompatActivity {

    String url;
    int lastEpisode;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_anime_selected);
        Intent intent = getIntent();
        url = intent.getStringExtra("url");
        Log.d("url",url);
       MyAsyncTask task= new MyAsyncTask();
       task.execute(url);

    }

    private class MyAsyncTask extends AsyncTask<String, List<AnimeModel>, Void> {

        @Override
        protected void onProgressUpdate(List<AnimeModel>... values) {
            super.onProgressUpdate(values);
            //since async works on different thread it cannot update the ui so we need to run the updating task on UI thread

            runOnUiThread(new Runnable() {

                @Override
                public void run() {

                    // Stuff that updates the UI

                }
            });
        }

        @Override
        protected Void doInBackground(String... url) {
            if(url[0]==null||url[0].length()<1){
                return null;
            }

            try {
                Document doc = Jsoup.connect(url[0]).get();

                Elements container= doc.select("div.anime_video_body");

                Elements container2=container.select("ul#episode_page");
                Elements range=container2.select("li");
                String lastEpisodeNumber="0";
                for(Element rng:range){
                    lastEpisodeNumber=rng.text();
                }
                if(lastEpisodeNumber.contains("-")){
                    String[] temp=lastEpisodeNumber.split("-");
                    lastEpisodeNumber=temp[1];
                }

              lastEpisode= Integer.parseInt(lastEpisodeNumber);

            } catch (IOException e) {
                e.printStackTrace();
            }




            return null;

        }

    }




}
