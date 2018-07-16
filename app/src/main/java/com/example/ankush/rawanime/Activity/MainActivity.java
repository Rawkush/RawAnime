package com.example.ankush.rawanime.Activity;

import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.adapters.RecyclerViewAdapter;
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
    RecyclerViewAdapter adapter;
    List<AnimeModel> list;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        list= new ArrayList<>();
        adapter= new RecyclerViewAdapter(list,this);
        recyclerView=findViewById(R.id.recycler_view);
        recyclerView.setHasFixedSize(true);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);
        MyAsyncTask task= new MyAsyncTask();
        task.execute();

    }



    //asynsc task
    private class MyAsyncTask extends AsyncTask<Void,List<AnimeModel>,Void>{

        @Override
        protected void onProgressUpdate(List<AnimeModel>... values) {
            super.onProgressUpdate(values);
            //since async works on different thread it cannot update the ui so we need to run the updating task on UI thread

            runOnUiThread(new Runnable() {

                @Override
                public void run() {

                    // Stuff that updates the UI
                    adapter.notifyDataSetChanged();

                }
            });
        }

        @Override
        protected Void doInBackground(Void... voids) {

            try {
                Document doc = Jsoup.connect(mainPageUrl).get();
                Elements container= doc.select("div.last_episodes.loaddub");
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
                    list.add(new AnimeModel(episode,imgLink,title,nextPageLink));
                    onProgressUpdate(list);
                }


            } catch (IOException e) {
                e.printStackTrace();
            }




            return null;

        }

    }


}
