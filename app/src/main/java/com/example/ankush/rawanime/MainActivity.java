package com.example.ankush.rawanime;

import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class MainActivity extends AppCompatActivity {

    private final String  mainPageUrl="https://www4.gogoanime.se/";

    TextView textView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        textView = (TextView)findViewById(R.id.textView);
        MyAsyncTask task= new MyAsyncTask();
        task.execute();
    }


    //asynsc task

    private class MyAsyncTask extends AsyncTask<Void,Void,Void>{


         @Override
         protected Void doInBackground(Void... voids) {
             List<AnimeModel> data= new ArrayList<>();

             if(mainPageUrl!=null){
                 try {
                     Document doc = Jsoup.connect(mainPageUrl).get();
                     Elements container= doc.select("div.last_episodes.loaddub"); //
                     Elements container2=container.select("ul.items");
                     Elements dataContainer=container2.select("li");
                     for(Element element:dataContainer){

                        Elements Episode=element.select("p.episode");
                        String episode= Episode.text();

                        Elements title=element.select("p.name");
                        String tile=title.text();
                        Log.d("title",tile);

                        Elements img=element.select("div.img");
                        Element links = img.select("a[href]").first(); // a with href
                        String nextPageLink=links.attr("href");
                        nextPageLink=mainPageUrl+nextPageLink;
                        Element ImageLink= links.select("img").first();
                        String  imgLink=ImageLink.attr("src");
                        Log.d("links",imgLink);

                     }


                 } catch (IOException e) {
                     e.printStackTrace();
                 }


             }

         return null;

         }

    }


}
