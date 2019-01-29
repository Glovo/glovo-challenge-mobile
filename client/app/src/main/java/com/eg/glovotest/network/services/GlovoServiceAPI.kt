package com.eg.glovotest.network.services

import com.eg.glovotest.network.jsonmappers.JsonCityDetailResponse
import com.eg.glovotest.network.jsonmappers.JsonCityResponse
import com.eg.glovotest.network.jsonmappers.JsonCountryResponse
import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path

interface GlovoServiceAPI {

    @GET("api/countries")
    fun getCountriesList()
            : Call<List<JsonCountryResponse>>

    @GET("api/cities")
    fun getCitiesList()
            : Call<List<JsonCityResponse>>

    @GET("api/cities/{code}")
    fun getCityDetails(@Path("code") cityCode : String)
            : Call<JsonCityDetailResponse>
}