package com.example.ankush.rawanime.models;

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

    public String getEpisode() {
        return episode;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public String getTitle() {
        return title;
    }

    public String getNextPageUrl() {
        return nextPageUrl;
    }
}
