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

public class FetchSearchedAnime {

    public List<AnimeModel> list;
    public FetchSearchedAnime(){
        list= new ArrayList<>();
    }

    public void setList(String url) {

        try {
            Document doc = Jsoup.connect(url).get();
            Elements container = doc.select("div.last_episodes");
            Elements container2 = container.select("ul.items");
            Elements dataContainer = container2.select("li");
            for (Element element : dataContainer) {
                Elements Episode = element.select("p.released");
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
                list.add(new AnimeModel(episode, imgLink, title, nextPageLink));
            }


        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public List<AnimeModel> getList() {
        return list;
    }
}
