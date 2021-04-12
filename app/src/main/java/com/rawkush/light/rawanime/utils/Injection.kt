package com.rawkush.light.rawanime.utils

import android.content.Context
import com.rawkush.light.rawanime.data.remote.RemoteDataSource

object Injection {

    fun provideRepository(context: Context): Repository {
        val api = ApiServiceBuilder
        val remoteDataSource = RemoteDataSource.getInstance(api)
        return Repository.getInstance(remoteDataSource)
    }
}