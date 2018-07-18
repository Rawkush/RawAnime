package com.example.ankush.rawanime.fetch;

import android.util.Log;

import com.example.ankush.rawanime.models.AnimeModel;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class fetchLatestAnimes {


    private  List<AnimeModel> list;

public fetchLatestAnimes(){
    list= new ArrayList<>();

}

    public void setList(String url) {

        try {
            Document doc = Jsoup.connect(url).get();
            Elements container = doc.select("div.added_series_body.popular");
            Elements dataContainer = container.select("li");

            for (Element element : dataContainer) {

                Elements dataCont=element.select("a[href]");
                Element data=dataCont.get(0);
                String title=dataCont.get(1).text();
                String nextPageLink = data.attr("href");
                Log.d("data",data.attr("href"));
                Element img=data.select("div.thumbnail-popular").first();
                String temp=img.after("url").toString();
                String imgUrl=getURL(temp);
                Elements episode = element.select("p");
                String latestEpisode=episode.get(1).text();
                Log.d("data3",""+episode.get(1).text());
                list.add(new AnimeModel(latestEpisode, imgUrl, title, nextPageLink));

/*
                Elements Episode = element.select("p.episode");
                String episode = Episode.text();
                Elements titles = element.select("p.name");
                String title = titles.text();
                Log.d("title", title);
                Elements img = element.select("div.img");
                Element links = img.select("a[href]").first(); // a with href
                String nextPageLink = links.attr("href");
                nextPageLink = url + nextPageLink;
                Element ImageLink = links.select("img").first();
                String imgLink = ImageLink.attr("src");
                Log.d("links", imgLink);
               // list.add(new AnimeModel(episode, imgLink, title, nextPageLink));
  */
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public List<AnimeModel> getList() {
        return list;
    }

    private String getURL(String murl){

        if(murl.contains("url")){
            String[] temp=murl.split("url");
           String[] strings= temp[1].split("'");
           return strings[1];
        }

    return null;
    }

}
