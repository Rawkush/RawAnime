package com.rawkush.light.rawanime.utils

import com.rawkush.light.rawanime.model.AnimeListItem
import com.rawkush.light.rawanime.model.TopAnimeResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path

interface ApiEndpoints {

    @GET("top/anime/1/{type}")
    suspend fun getTopAnime(@Path("type") type: String): TopAnimeResponse
}