package com.rawkush.light.rawanime.utils

import com.rawkush.light.rawanime.data.DataSource
import com.rawkush.light.rawanime.data.remote.RemoteDataSource
import com.rawkush.light.rawanime.model.AnimeListItem


class Repository private constructor(private val remoteDataSource:
                                     RemoteDataSource) :
    DataSource {

    companion object {
        @Volatile
        private var instance: Repository? = null
        fun getInstance(remoteData: RemoteDataSource): Repository =
            instance ?: synchronized(this) {
                instance ?: Repository(remoteData)
            }
    }

    override suspend fun getTopAnime(type: String): List<AnimeListItem> {
        lateinit var animeResult: List<AnimeListItem>
        remoteDataSource.getTopAnime(type, object : RemoteDataSource.GetAnimeCallback {
            override fun onAnimeReceived(animeList: List<AnimeListItem>) {
                animeResult = animeList
            }
        })
        return animeResult
    }


}