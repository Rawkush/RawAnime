package com.rawkush.light.rawanime.data

import com.rawkush.light.rawanime.model.AnimeListItem

interface DataSource {

     suspend fun getTopAnime(type: String): List<AnimeListItem>


}