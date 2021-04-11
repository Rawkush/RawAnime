package com.rawkush.light.rawanime.views.fragments.adapter

import android.widget.ImageView
import androidx.databinding.BindingAdapter
import com.bumptech.glide.Glide

class BindingAdapter {

    @BindingAdapter("showImageFromUrl")
    fun showImageFromUrl(imageView: ImageView, url: String?) {
        Glide.with(imageView.context).load(url).into(imageView)
    }

}