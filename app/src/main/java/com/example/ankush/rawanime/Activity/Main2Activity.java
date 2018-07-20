package com.example.ankush.rawanime.Activity;

import android.support.design.widget.TabLayout;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.fragment.PopularOnGoing;
import com.example.tabviewlibrary.TabView;
import com.example.tabviewlibrary.model.FragmentModel;

public class Main2Activity extends TabView {

    TabLayout tabLayout;
    ViewPager viewPager;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        initTabView();
        addFragment(new FragmentModel(new PopularOnGoing(),"Popular Ongoing"));
    }


}
