package com.rawkush.light.rawanime.data.remote

import com.rawkush.light.rawanime.model.AnimeListItem
import com.rawkush.light.rawanime.utils.ApiEndpoints
import com.rawkush.light.rawanime.utils.ApiServiceBuilder
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext


class RemoteDataSource private constructor(private val apiConfig:
                                           ApiServiceBuilder
) {


    companion object {
        @Volatile
        private var instance: RemoteDataSource? = null
        fun getInstance(api: ApiServiceBuilder): RemoteDataSource = instance ?: synchronized(this) {
            instance ?: RemoteDataSource(api)
        }
    }

    suspend fun getTopAnime(type: String, callback: GetAnimeCallback) {
        withContext(Dispatchers.IO) {
            val animes = apiConfig.api.getTopAnime(type).top
            callback.onAnimeReceived(animes)
        }
    }


    interface GetAnimeCallback {
        fun onAnimeReceived(animeList: List<AnimeListItem>)
    }
}