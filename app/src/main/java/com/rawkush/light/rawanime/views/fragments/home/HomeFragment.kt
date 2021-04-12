package com.rawkush.light.rawanime.views.fragments.home

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import com.rawkush.light.rawanime.R
import com.rawkush.light.rawanime.databinding.FragmentHomeBinding
import com.rawkush.light.rawanime.model.AnimeListItem
import com.rawkush.light.rawanime.utils.ApiEndpoints
import com.rawkush.light.rawanime.utils.ApiServiceBuilder
import com.rawkush.light.rawanime.utils.More
import com.rawkush.light.rawanime.views.fragments.adapter.HomeRecyclerViewAdapter
import com.rawkush.light.rawanime.views.model.ViewModelFactory

class HomeFragment : Fragment() {


    private lateinit var binding: FragmentHomeBinding
    private lateinit var viewModel: HomeViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        binding = FragmentHomeBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val viewModelFactory = ViewModelFactory.getInstance(requireContext())
        viewModel = ViewModelProvider(this, viewModelFactory)[HomeViewModel::class.java]
        setupVisibility()
        observeData()
    }

    private fun setupVisibility() {
        binding.apply {


        //            topAiringText.gone()
//            moreAiring.gone()
//            progressViewAiring.visible()
        }
    }

    private fun observeData() {
        val adapterAiring = HomeRecyclerViewAdapter { id -> showDetail(id) }

        viewModel.apply {
            animeAiring.observe(viewLifecycleOwner, { anime ->
                if (anime.isNotEmpty()) {
                    adapterAiring.setData(anime)
                    binding.apply {
//                        progressViewAiring.gone()
//                        topAiringText.visible()
//                        moreAiring.visible()
                    }
                }
            })

            binding.apply {
                rvTopAiring.apply {
                    setHasFixedSize(true)
                    adapter = adapterAiring
                }
            }
        }
    }

    private fun showDetail(id: Int) {

    }

}