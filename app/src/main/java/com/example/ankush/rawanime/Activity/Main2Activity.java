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
        setContentView(R.layout.activity_main2);
        initTabView();
        addFragment(new FragmentModel(new PopularOnGoing(),"Popular Ongoings"));
    }

    @Override
    public void initViewPager() {
        super.initViewPager();
        // initialise your viewpager here
        viewPager=(ViewPager)findViewById(R.id.viewpager);
    }
    @Override
    public void initTabView() {
        super.initTabView();
        //initialise your tabLayout Here and set it up with viepager, eg below
        tabLayout = (TabLayout) findViewById(R.id.tabs);
        tabLayout.setupWithViewPager(viewPager);
    }
}
