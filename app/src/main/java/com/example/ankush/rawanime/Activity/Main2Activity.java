package com.example.ankush.rawanime.Activity;

import android.content.Intent;
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
import com.mancj.materialsearchbar.MaterialSearchBar;
import com.mancj.materialsearchbar.SimpleOnSearchActionListener;

public class Main2Activity extends TabView {

    TabLayout tabLayout;
    ViewPager viewPager;
    private MaterialSearchBar searchBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);
        viewPager=findViewById(R.id.viewpager);
        tabLayout=findViewById(R.id.tabs);
        initViewpagerAndTablayout(viewPager,tabLayout);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT); // Make to run your application only in portrait mode
        addFragment(new FragmentModel(new RecentUpdates(),"Recently Updated"));
        addFragment(new FragmentModel(new PopularOnGoing(),"Popular Ongoing"));
        searchBar = findViewById(R.id.searchBar);
        searchBar.setHint("Enter your Search Here");

        searchBar.setOnSearchActionListener(new SimpleOnSearchActionListener() {
            @Override
            public void onSearchStateChanged(boolean enabled) {
                super.onSearchStateChanged(enabled);

            }

            @Override
            public void onSearchConfirmed(CharSequence text) {
                super.onSearchConfirmed(text);
                Intent intent= new Intent(getApplicationContext(),searchAnime.class);
                String message=text.toString();
                intent.putExtra("text",message);
                startActivity(intent);
            }

            @Override
            public void onButtonClicked(int buttonCode) {
                super.onButtonClicked(buttonCode);

            }
        });
    }


}
