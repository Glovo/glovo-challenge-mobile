package com.eg.glovotest.daggerInjection

import android.app.Application
import android.content.Context
import android.content.SharedPreferences
import com.eg.glovotest.network.repositories.GlovoDataRepository
import com.eg.glovotest.network.repositories.GlovoDataRepositoryImp
import com.eg.glovotest.network.services.GlovoServiceAPI
import com.eg.glovotest.network.services.RetrofitRequest
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import dagger.Module
import dagger.Provides
import retrofit2.Retrofit
import javax.inject.Singleton


@Module
class AppModule(internal val application : Application) {

    @Provides
    fun provideFusedLocationProvider(): FusedLocationProviderClient {
        return LocationServices.getFusedLocationProviderClient(application.baseContext)
    }

    @Provides
    fun provideGlovoRepository(): GlovoDataRepository {
        return GlovoDataRepositoryImp(provideGlovoService())
    }

    @Provides
    fun provideGlovoService(): GlovoServiceAPI {
        return provideRetrofitClient().create(GlovoServiceAPI::class.java)
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