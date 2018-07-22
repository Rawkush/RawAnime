package com.example.ankush.rawanime.Activity;

import android.content.pm.ActivityInfo;
import android.support.design.widget.TabLayout;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.fragment.PopularOnGoing;
import com.example.ankush.rawanime.fragment.RecentUpdates;
import com.example.tabviewlibrary.TabView;
import com.example.tabviewlibrary.model.FragmentModel;

public class Main2Activity extends TabView {

    TabLayout tabLayout;
    ViewPager viewPager;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT); // Make to run your application only in portrait mode
        initTabView();
        addFragment(new FragmentModel(new RecentUpdates(),"Recently Updated"));
        addFragment(new FragmentModel(new PopularOnGoing(),"Popular Ongoing"));
    }


}
