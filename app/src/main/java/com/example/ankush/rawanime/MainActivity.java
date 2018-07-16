package com.example.ankush.rawanime;

import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.widget.TextView;

import com.example.ankush.rawanime.models.AnimeModel;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class MainActivity extends AppCompatActivity {

    private final String  mainPageUrl="https://www4.gogoanime.se/";
    RecyclerView recyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        MyAsyncTask task= new MyAsyncTask();
        task.execute();
    }


    //asynsc task

    private class MyAsyncTask extends AsyncTask<Void,Void,Void>{

        @Override
        protected Void doInBackground(Void... voids) {
            List<AnimeModel> data= new ArrayList<>();

            try {
                Document doc = Jsoup.connect(mainPageUrl).get();
                Elements container= doc.select("div.last_episodes.loaddub"); //
                Elements container2=container.select("ul.items");
                Elements dataContainer=container2.select("li");
                for(Element element:dataContainer){

                    Elements Episode=element.select("p.episode");
                    String episode= Episode.text();
                    Elements titles=element.select("p.name");
                    String title=titles.text();
                    Log.d("title",title);
                    Elements img=element.select("div.img");
                    Element links = img.select("a[href]").first(); // a with href
                    String nextPageLink=links.attr("href");
                    nextPageLink=mainPageUrl+nextPageLink;
                    Element ImageLink= links.select("img").first();
                    String  imgLink=ImageLink.attr("src");
                    Log.d("links",imgLink);
                    data.add(new AnimeModel(episode,imgLink,title,nextPageLink));

                }


            } catch (IOException e) {
                e.printStackTrace();
            }




            return null;

        }

    }


}
