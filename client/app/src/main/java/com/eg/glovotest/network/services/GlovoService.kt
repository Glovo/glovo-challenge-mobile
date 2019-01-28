package com.eg.glovotest.network.services

import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path

interface GlovoService {

    @GET("countries")
    fun getCountriesList()
            : Call<ResponseBody>

    @GET("cities")
    fun getCitiesList()
            : Call<ResponseBody>

    @GET("cities/{city_code}")
    fun getCityDetails(@Path("city_code") cityCode : String)
            : Call<ResponseBody>
}