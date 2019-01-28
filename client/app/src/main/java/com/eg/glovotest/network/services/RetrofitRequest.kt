package com.eg.glovotest.network.services

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitRequest {

    companion object {

        val retrofit: Retrofit =  Retrofit.Builder()
                .baseUrl("http://localhost:3000/api/")
                .addConverterFactory(GsonConverterFactory.create())
                .build()

    }

}