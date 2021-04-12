package com.rawkush.light.rawanime.views.fragments.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.rawkush.light.rawanime.R
import com.rawkush.light.rawanime.databinding.ItemAnimeListBinding
import com.rawkush.light.rawanime.model.AnimeListItem

class HomeRecyclerViewAdapter(private val showDetail: (id: Int) -> Unit) :
    RecyclerView.Adapter<HomeRecyclerViewAdapter.AnimeViewHolder>() {

    private var listData = ArrayList<AnimeListItem>()

    fun setData(newListData: List<AnimeListItem>?) {
        if (newListData == null) return
        listData.clear()
        listData.addAll(newListData)
        notifyDataSetChanged()
    }


    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): HomeRecyclerViewAdapter.AnimeViewHolder {
        val view: ItemAnimeListBinding = DataBindingUtil.inflate(
            LayoutInflater.from(parent.context),
            R.layout.item_anime_list,
            parent,
            false
        )
        return AnimeViewHolder(view)
    }


    override fun onBindViewHolder(holder: HomeRecyclerViewAdapter.AnimeViewHolder, position: Int) {
        val item = listData[position]
        holder.bind(item)
    }

    override fun getItemCount(): Int {
       return listData.size
    }

    inner class AnimeViewHolder(private val binding: ItemAnimeListBinding) :
        RecyclerView.ViewHolder(binding.root) {
        fun bind(item: AnimeListItem){
            binding.anime = item
            binding.executePendingBindings()
           // binding.root.setOnClickListener { item.id?.let { it1 -> showDetail(it1) } }
        }

    }
}