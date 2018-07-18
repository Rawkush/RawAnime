package com.example.ankush.rawanime.Activity;

import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.adapters.RecyclerViewAdapter;
import com.example.ankush.rawanime.fetch.fetchLatestAnimes;
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
    private class MyAsyncTask extends AsyncTask<Void,List<AnimeModel>,List<AnimeModel>>{

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
        protected List<AnimeModel> doInBackground(Void... voids) {



            List<AnimeModel> list=new ArrayList<>();
            try {
                Document doc = Jsoup.connect(mainPageUrl).get();
                Elements container = doc.select("div.pagination.recent");
                Log.d("akd",""+container.html());


            } catch (IOException e) {
                e.printStackTrace();
            }


            list.addAll(fetchLatestAnimes.fetch(mainPageUrl));
            onProgressUpdate(list);
            return null;

        }


        @Override
        protected void onPostExecute(List<AnimeModel> animeModelsList) {
            super.onPostExecute(animeModelsList);
            runOnUiThread(new Runnable() {

                @Override
                public void run() {

                    // Stuff that updates the UI
                    adapter.notifyDataSetChanged();

                }
            });
        }
    }


}
