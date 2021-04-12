package com.rawkush.light.rawanime.views.fragments.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.rawkush.light.rawanime.model.AnimeListItem
import com.rawkush.light.rawanime.utils.Repository
import kotlinx.coroutines.launch

class HomeViewModel(private val repository: Repository) : ViewModel() {
    private var _animeAiring = MutableLiveData<List<AnimeListItem>>()
    val animeAiring: LiveData<List<AnimeListItem>>
        get() = _animeAiring


    init {
        viewModelScope.launch {
            try {
                val resultAiring = repository.getTopAnime("airing")
                _animeAiring.value = resultAiring
            } catch (e: Throwable) {
                e.printStackTrace()
            }
        }
    }
}