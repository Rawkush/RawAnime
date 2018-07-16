package com.example.ankush.rawanime;

public class AnimeModel {

    String episode;
    String imgUrl;
    String title;
    String nextPageUrl;
    public AnimeModel(String episode,String imgUrl,String title,String nextPageUrl){
        this.episode=episode;
        this.imgUrl= imgUrl;
        this.title=title;
        this.nextPageUrl=nextPageUrl;
    }


}
