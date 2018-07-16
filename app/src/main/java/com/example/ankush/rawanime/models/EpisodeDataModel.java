package com.example.ankush.rawanime.models;

public class EpisodeDataModel {

    public EpisodeDataModel(String episode, String episodeUrl) {
        this.episode = episode;
        this.episodeUrl = episodeUrl;
    }

    String episode;
    String episodeUrl;


    public String getEpisode() {
        return episode;
    }

    public String getEpisodeUrl() {
        return episodeUrl;
    }
}
