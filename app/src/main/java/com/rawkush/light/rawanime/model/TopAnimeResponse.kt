package com.rawkush.light.rawanime.model

import com.squareup.moshi.Json


data class TopAnimeResponse(
    @Json(name = "top")
    val top: List<AnimeListItem>
)