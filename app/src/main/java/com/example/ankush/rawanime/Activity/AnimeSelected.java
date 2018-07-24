package com.example.ankush.rawanime.Activity;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Parcelable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.adapters.SelectedAnimeAdapter;
import com.example.ankush.rawanime.models.AnimeModel;
import com.example.ankush.rawanime.models.EpisodeDataModel;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.regex.Pattern;

public class AnimeSelected extends AppCompatActivity {
    List<EpisodeDataModel> episodesData;
    int lastEpisode;
    RecyclerView recyclerView;
    ArrayList<EpisodeDataModel> data;
    SelectedAnimeAdapter adapter;
    String episodeUrl;
    String nextUrl;
    final String baseUrl="https://www4.gogoanime.se";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_anime_selected);
        episodesData=new ArrayList<>();
        adapter= new SelectedAnimeAdapter(episodesData,this);
        recyclerView=findViewById(R.id._selected_recycler_view);
        recyclerView.setHasFixedSize(true);
        data=new ArrayList<>();
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        recyclerView.setAdapter(adapter);
        Intent intent = getIntent();
        final String url = intent.getStringExtra("url");  // url part like..../onepiece/category/season
        Log.d("url",url);
        MyAsyncTask task = new MyAsyncTask();

        if(url.contains("https"))
        {
            episodeUrl=getGeneralUrl(url); // getting general url of the page
            Log.d("new", episodeUrl);
            task.execute(url);
        }
        else {
            episodeUrl = baseUrl + url;
            Log.d("new", episodeUrl);
            task.execute(episodeUrl);
        }
    }

    private class MyAsyncTask extends AsyncTask<String, List<AnimeModel>, Void> {


        @Override
        protected Void doInBackground(String... url) {
            if(url[0]==null||url[0].length()<1){
                return null;
            }

            try {
                Document doc = Jsoup.connect(url[0]).get();
                Elements container= doc.select("div.anime_video_body");
                Element download=container.select("div.download-anime").first();
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
                nextUrl=download.select("a").attr("href");
                nextUrl=getGeneralDownloadUrl(nextUrl);
                Log.d("ashdb",download.select("a").attr("href"));


            } catch (IOException e) {
                e.printStackTrace();
            }

            return null;

        }


        @Override
        protected void onPostExecute(Void aVoid) {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    // Stuff that updates the UI

                    for(int i=1;i<=lastEpisode;i++) {
                        episodesData.add(new EpisodeDataModel("episode " + i, nextUrl + i));
                    }

                 /*
                    episodeUrl=getProperUrl(episodeUrl);
                    for(int i=1;i<=lastEpisode;i++){
                        if(episodeUrl.contains("episode")){
                            episodesData.add(new EpisodeDataModel("episode "+i,episodeUrl+"-"+i));

                        }else
                        episodesData.add(new EpisodeDataModel("episode "+i,episodeUrl+"-episode-"+i));

                    }
*/





                    Collections.reverse(episodesData);
                    adapter.notifyDataSetChanged();

                }
            });

        }

    }


    public String getGeneralDownloadUrl(String murl){
        String[] temp=murl.split(Pattern.quote("+"));
        String URL=null;
        for(int i=0;i<temp.length;i++){
            if(i==0){
                URL=temp[i];
            }else
            if(i!=temp.length-1){
                URL=URL+"-"+temp[i];
            }

        }

        if(!parseStrToInt(temp[temp.length-1])){
            URL=URL+"-"+temp[temp.length-1];
        }

        return URL;
    }

public String getGeneralUrl(String murl){
    String[] temp=murl.split("-");
      String URL=null;
      for(int i=0;i<temp.length;i++){
          if(i==0){
              URL=temp[i];
          }else
             if(i!=temp.length-1){
              URL=URL+"-"+temp[i];
             }

      }

      if(!parseStrToInt(temp[temp.length-1])){
          URL=URL+"-"+temp[temp.length-1];
      }

return URL;
}
    public  boolean parseStrToInt(String str) {
        if (str.matches("\\d+")) {
            return true;
        } else {
            return false;
        }
    }


    private  String getProperUrl(String url){
      return url.replaceFirst("category/","");


        }

}
