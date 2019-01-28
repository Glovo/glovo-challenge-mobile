package com.eg.glovotest.daggerInjection

import android.app.Application
import android.content.Context
import android.content.SharedPreferences
import com.eg.glovotest.network.services.GlovoService
import com.eg.glovotest.network.services.RetrofitRequest
import dagger.Module
import dagger.Provides
import retrofit2.Retrofit
import javax.inject.Singleton


@Module
class AppModule(internal val application : Application) {

    @Provides
    fun provideGlovoService(): GlovoService {
        return provideRetrofitClient().create(GlovoService::class.java)
    }

    @Provides
    @Singleton
    fun provideRetrofitClient(): Retrofit {
        return RetrofitRequest.retrofit
    }

    @Provides
    @Singleton
    fun providePreferences(): SharedPreferences {
        return application.getSharedPreferences("REPOSITORY_PREFERENCES",
                Context.MODE_PRIVATE)
    }
}