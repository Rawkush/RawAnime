package com.example.ankush.rawanime.Activity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;
import com.gecdevelopers.scrapper.EpisodeModel;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class WatchDownload extends AppCompatActivity {
    String url;
    String videoUrl;
    ArrayList <EpisodeModel> servers;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = getIntent();
        servers=new ArrayList<>();
        url = intent.getStringExtra("url");
        Log.d("urlWatch",url);
        Toast.makeText(this,url,Toast.LENGTH_SHORT).show();
        MyAsyncTask task=new MyAsyncTask();
        task.execute(url);
    }



    @SuppressLint("StaticFieldLeak")
    private class MyAsyncTask extends AsyncTask<String,List<EpisodeModel>,Void> {
        @Override
        protected Void doInBackground(String... url) {

            try {
                Document doc = Jsoup.connect(url[0]).get();

                Elements container= doc.select("div.content_c_bg");
                Elements container1= container.select("div.mirror_link");
                Elements container2= container1.select("div.dowload");
                Elements container3= container2.select("a");
                Log.d("check", container3.outerHtml());

                for(Element li:container1) {
                    videoUrl=li.attr("href");
                    servers.add(new EpisodeModel("",videoUrl));
                    Log.d("sjdnckkd", li.select("a").text());

                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            return null;

        }


        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);

        }

    }

}
