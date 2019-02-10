package com.example.ankush.rawanime.Activity;


import android.annotation.TargetApi;
import android.app.DownloadManager;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Environment;
import android.os.Handler;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
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
    private boolean videoLoaded=false;
    private Handler mHandler;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_watch_or_download);
        Intent intent = getIntent();
        url = intent.getStringExtra("url");
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


        mWebView.setWebViewClient(new WebViewClient(){
            @SuppressWarnings("deprecation")
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                //view.loadUrl(url);
 //               https://cobalten.com/?auction_id=dee88bd0-1964-4a4c-a59a-f83857dc443d&ip=736d6dd364260474af661aa74d6e326b&pbk3=62bde385cb16cb695f6005ac64d1f0926624108803769143284&r=%2Foc%2Fhan&uuid=22c80168-fba3-4fb7-af7b-df4479f2e612&co=1&rf=1&zoneid=756262&xref=dmlkc3RyZWFtaW5nLmlv&fs=0&cf=0&sw=360&sh=640&sah=640&wx=0&wy=0&ww=360&wh=616&cw=360&wiw=360&wih=616&wfc=2&pl=https%3A%2F%2Fvidstreaming.io%2Fstreaming.php%3Fid%3DMTExMTUx%26title%3DSeishun%2BButa%2BYarou%2Bwa%2BBunny%2BGirl%2BSenpai%2Bno%2BYume%2Bwo%2BMinai%2BEpisode%2B7&drf=&np=0&pt=0&nb=1&ng=1&ix=0&nw=0
                if (url != null && !url.startsWith(videoUrl)) {
                    view.goBack();
                    return true;
                } else {
                    return false;
                }

            }

            @TargetApi(Build.VERSION_CODES.N)
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
               // view.loadUrl(request.getUrl().toString());
                if (request.getUrl() != null && !request.getUrl().toString().startsWith(videoUrl)) {
                    view.goBack();
                    return true;
                } else {
                    return false;
                }
            }

            @Nullable
            @Override
            public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {
                String url =request.getUrl().toString();
                if(request.isForMainFrame()){
                   if (!videoLoaded){
                       videoLoaded=true;
                   }else
                       return null;
                }
                if(url.endsWith(".mp4")||url.endsWith("mkv")||url.endsWith("webm")){

                    startDownload(url);

                    return null;

                }


                Log.e("URL",request.getUrl().toString());
                return super.shouldInterceptRequest(view, request);



            }
        });




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



    private void startDownload(String url){
        DownloadManager.Request r = new DownloadManager.Request(Uri.parse(url));

// This put the download in the same Download dir the browser uses
        r.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, "fileName");

// When downloading music and videos they will be listed in the player
// (Seems to be available since Honeycomb only)
        r.allowScanningByMediaScanner();

// Notify user when download is completed
// (Seems to be available since Honeycomb only)
        r.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);

// Start download
        DownloadManager dm = (DownloadManager) getSystemService(DOWNLOAD_SERVICE);
        dm.enqueue(r);
    }

}
