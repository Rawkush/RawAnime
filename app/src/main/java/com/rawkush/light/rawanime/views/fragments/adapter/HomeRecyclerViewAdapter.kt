package com.rawkush.light.rawanime.views.fragments.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.rawkush.light.rawanime.R
import com.rawkush.light.rawanime.databinding.ItemAnimeListBinding
import com.rawkush.light.rawanime.model.AnimeListItem

class HomeRecyclerViewAdapter(private val items: List<AnimeListItem>)  : RecyclerView.Adapter <HomeRecyclerViewAdapter.AnimeViewHolder>() {


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): AnimeViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding = ItemAnimeListBinding.inflate(inflater)
        return AnimeViewHolder(binding)
    }

    override fun onBindViewHolder(holder: AnimeViewHolder, position: Int) {
        return holder.bind(items[position])
    }

    override fun getItemCount(): Int {
       return items.size
    }


    inner class AnimeViewHolder(val binding: ItemAnimeListBinding) : RecyclerView.ViewHolder(binding.root) {
        fun bind(item: AnimeListItem){
            binding.anime = item
            binding.executePendingBindings()
        }

    }
}