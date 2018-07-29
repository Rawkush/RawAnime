package com.example.ankush.rawanime.Activity;


import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.models.AnimeModel;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.List;

public class StreamVideo extends AppCompatActivity {

    String url;
    String videoUrl;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_watch_or_download);
        Intent intent = getIntent();
        url = intent.getStringExtra("url");
        Toast.makeText(this,url,Toast.LENGTH_SHORT).show();
        MyAsyncTask task=new MyAsyncTask();
        task.execute(url);
    }



    private class MyAsyncTask extends AsyncTask<String,List<AnimeModel>,Void> {


        @Override
        protected Void doInBackground(String... url) {

            try {
                Document doc = Jsoup.connect(url[0]).get();

                Elements container= doc.select("div.anime_video_body");
                Elements container1= container.select("div.anime_video_body_watch");
                Elements link = container1.select("iframe"); // a with href
                String  videoLink=link.attr("src");

                videoUrl="https:"+videoLink;

            } catch (IOException e) {
                e.printStackTrace();
            }


            try {

                Document doc = Jsoup.connect(videoUrl).get();
                Elements container =doc.select("#myVideo");
                String  videoLink=container.text();

                Log.d("h",videoLink);

            } catch (IOException e) {
                e.printStackTrace();
            }


            return null;

        }


        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);
            runOnUiThread(new Runnable() {

                @Override
                public void run() {
                    // Stuff that updates the UI
                    Intent i = new Intent(Intent.ACTION_VIEW);
                    i.setData(Uri.parse(videoUrl));
                    Log.d("videourl",videoUrl);
                    startActivity(i);
                    finish();
                }
            });

        }

    }


}
