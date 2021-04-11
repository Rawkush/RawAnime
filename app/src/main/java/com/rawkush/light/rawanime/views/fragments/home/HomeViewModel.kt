package com.rawkush.light.rawanime.views.fragments.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.rawkush.light.rawanime.model.AnimeListItem

class HomeViewModel() : ViewModel() {
    private var _animeAiring = MutableLiveData<List<AnimeListItem>>()

}