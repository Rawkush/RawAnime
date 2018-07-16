package com.example.ankush.rawanime.Activity;

import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import com.example.ankush.rawanime.R;
import com.example.ankush.rawanime.models.AnimeModel;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.List;

public class watchOrDownload extends AppCompatActivity {
    String url;
    String videoUrl;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_watch_or_download);
        Intent intent = getIntent();
         url=intent.getStringExtra("url");

    }



    private class MyAsyncTask extends AsyncTask<Void,List<AnimeModel>,Void> {

        @Override
        protected void onProgressUpdate(List<AnimeModel>... values) {
            super.onProgressUpdate(values);
            //since async works on different thread it cannot update the ui so we need to run the updating task on UI thread

            runOnUiThread(new Runnable() {

                @Override
                public void run() {

                    // Stuff that updates the UI

                    Intent intent = new Intent(Intent.ACTION_VIEW);
                    intent.setDataAndType(Uri.parse("http://ur URL"), "video/*");
                    startActivity(Intent.createChooser(intent, "Complete action using"));

                }
            });
        }

        @Override
        protected Void doInBackground(Void... voids) {

            try {
                Document doc = Jsoup.connect(url).get();
                Elements container= doc.select("div.jw-media.jw-reset");
                Element links = container.select("video.jw-video.jw-reset").first(); // a with href
                String  videoLink=links.attr("src");
                Log.d("videoLink",videoLink);


            } catch (IOException e) {
                e.printStackTrace();
            }




            return null;

        }

    }


}
