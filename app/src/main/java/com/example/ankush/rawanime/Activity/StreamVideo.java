package com.example.ankush.rawanime.Activity;


import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import android.widget.Toast;

import com.example.ankush.rawanime.R;
import com.gecdevelopers.scrapper.AnimeModel;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.List;

public class StreamVideo extends AppCompatActivity {

    String url;
    String videoUrl;
    private WebView mWebView;

    private View mCustomView;
    private int mOriginalSystemUiVisibility;
    private int mOriginalOrientation;
    private WebChromeClient.CustomViewCallback mCustomViewCallback;
    protected FrameLayout mFullscreenContainer;
    private Handler mHandler;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_watch_or_download);
        Intent intent = getIntent();
        url = intent.getStringExtra("url");
        Log.d("gqsgamhgsma hdg",url);
        mWebView = (WebView) findViewById(R.id.webview);
        Toast.makeText(this,url,Toast.LENGTH_SHORT).show();
        MyAsyncTask task=new MyAsyncTask();
        task.execute(url);
        setUpWebViewDefaults(mWebView);

    }

    private void setUpWebViewDefaults(WebView webView) {
        WebSettings settings = webView.getSettings();

        // Enable Javascript
        settings.setJavaScriptEnabled(true);

        // Use WideViewport and Zoom out if there is no viewport defined
        settings.setUseWideViewPort(true);
        settings.setLoadWithOverviewMode(true);

        // Enable pinch to zoom without the zoom buttons
        settings.setBuiltInZoomControls(true);

        // Allow use of Local Storage
        settings.setDomStorageEnabled(true);

        if(Build.VERSION.SDK_INT > Build.VERSION_CODES.HONEYCOMB) {
            // Hide the zoom controls for HONEYCOMB+
            settings.setDisplayZoomControls(false);
        }

        // Enable remote debugging via chrome://inspect
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            WebView.setWebContentsDebuggingEnabled(true);
        }

        webView.setWebViewClient(new WebViewClient());
    }



    private class MyAsyncTask extends AsyncTask<String,List<AnimeModel>,Void> {


        @Override
        protected Void doInBackground(String... url) {

            try {
                Document doc = Jsoup.connect(url[0]).get();

                Elements container= doc.select("div.anime_video_body");
                Elements container1= container.select("div.anime_video_body_watch");
                Elements link = container1.select("iframe"); // a with href
                String  videoLink=link.attr("src");

                videoUrl="https:"+videoLink;

            } catch (IOException e) {
                e.printStackTrace();
            }


            try {

                Document doc = Jsoup.connect(videoUrl).get();
                Elements container =doc.select("#myVideo");
                String  videoLink=container.text();

                Log.d("h",videoLink);

            } catch (IOException e) {
                e.printStackTrace();
            }


            return null;

        }


        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);
            runOnUiThread(new Runnable() {

                @Override
                public void run() {
                    // Stuff that updates the UI
                 /*   Intent i = new Intent(Intent.ACTION_VIEW);
                    i.setData(Uri.parse(videoUrl));
                    Log.d("videourl",videoUrl);
                    startActivity(i);
                    finish();*/
                    loadPage();

                }
            });

        }

    }

    public void loadPage(){

        mWebView.loadUrl(videoUrl);



        mWebView.setWebChromeClient(new WebChromeClient() {

            @Override
            public Bitmap getDefaultVideoPoster() {

                return BitmapFactory.decodeResource(getApplicationContext().getResources(),
                        R.drawable.video_poster);
            }


            @Override
            public void onShowCustomView(View view,
                                         WebChromeClient.CustomViewCallback callback) {
                // if a view already exists then immediately terminate the new one
                if (mCustomView != null) {
                    onHideCustomView();
                    return;
                }

                // 1. Stash the current state
                mCustomView = view;
                mOriginalSystemUiVisibility = getWindow().getDecorView().getSystemUiVisibility();
                mOriginalOrientation = getRequestedOrientation();

                // 2. Stash the custom view callback
                mCustomViewCallback = callback;

                // 3. Add the custom view to the view hierarchy
                FrameLayout decor = (FrameLayout) getWindow().getDecorView();
                decor.addView(mCustomView, new FrameLayout.LayoutParams(
                        ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.MATCH_PARENT));


                // 4. Change the state of the window
                getWindow().getDecorView().setSystemUiVisibility(
                        View.SYSTEM_UI_FLAG_LAYOUT_STABLE |
                                View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION |
                                View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN |
                                View.SYSTEM_UI_FLAG_HIDE_NAVIGATION |
                                View.SYSTEM_UI_FLAG_FULLSCREEN |
                                View.SYSTEM_UI_FLAG_IMMERSIVE);
                setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
            }

            @Override
            public void onHideCustomView() {
                // 1. Remove the custom view
                FrameLayout decor = (FrameLayout)getWindow().getDecorView();
                decor.removeView(mCustomView);
                mCustomView = null;

                // 2. Restore the state to it's original form
                getWindow().getDecorView()
                        .setSystemUiVisibility(mOriginalSystemUiVisibility);
                setRequestedOrientation(mOriginalOrientation);

                // 3. Call the custom view callback
                mCustomViewCallback.onCustomViewHidden();
                mCustomViewCallback = null;

            }

        });



    }


}
