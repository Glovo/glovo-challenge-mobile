package com.eg.glovotest.network.repositories

import android.arch.lifecycle.LiveData
import android.arch.lifecycle.MutableLiveData
import android.util.Log
import javax.inject.Singleton
import retrofit2.Call
import retrofit2.Callback
import com.eg.glovotest.network.entities.City
import com.eg.glovotest.network.entities.CityDetails
import com.eg.glovotest.network.entities.Country
import com.eg.glovotest.network.jsonmappers.JsonCityDetailResponse
import com.eg.glovotest.network.jsonmappers.JsonCityResponse
import com.eg.glovotest.network.jsonmappers.JsonCountryResponse
import com.eg.glovotest.network.services.GlovoService
import retrofit2.Response


@Singleton
class GlovoDataRepositoryImp(val glovoService: GlovoService) : GlovoDataRepository {

    override fun getCountries(): LiveData<List<Country>> {
        var data = MutableLiveData<List<Country>>()

        glovoService.getCountriesList().enqueue(object : Callback<List<JsonCountryResponse>> {

            override fun onFailure(call: Call<List<JsonCountryResponse>>, t: Throwable) {
                Log.e("Network Call Failed", t.toString())
                // For the sake of simplicity i skip error handling here
                // I should wrap the response in a customized Observer to a better handling on the view.
            }

            override fun onResponse(call: Call<List<JsonCountryResponse>>, response: Response<List<JsonCountryResponse>>) {
                response.body()?.let {
                    var countriesList = mutableListOf<Country>()
                    for (countryJson in it){
                        countriesList.add(countryJson.getData())
                    }
                    data.value = countriesList
                }
            }

        })
        return data
    }

    override fun getCities(): LiveData<List<City>> {
        var data = MutableLiveData<List<City>>()

        glovoService.getCitiesList().enqueue(object : Callback<List<JsonCityResponse>> {

            override fun onFailure(call: Call<List<JsonCityResponse>>, t: Throwable) {
                Log.e("Network Call Failed", t.toString())
                // For the sake of simplicity i skip error handling here
                // I should wrap the response in a customized Observer to a better handling on the view.
            }

            override fun onResponse(call: Call<List<JsonCityResponse>>, response: Response<List<JsonCityResponse>>) {
                response.body()?.let {
                    var citiesList = mutableListOf<City>()
                    for (cityJson in it){
                        citiesList.add(cityJson.getData())
                    }
                    data.value = citiesList
                }
            }

        })
        return data
    }

    override fun getCityDetail(cityId: String): LiveData<CityDetails> {
        var data = MutableLiveData<CityDetails>()

        glovoService.getCityDetails(cityId).enqueue(object : Callback<JsonCityDetailResponse> {

            override fun onFailure(call: Call<JsonCityDetailResponse>, t: Throwable) {
                Log.e("Network Call Failed", t.toString())
                // For the sake of simplicity i skip error handling here
                // I should wrap the response in a customized Observer to a better handling on the view.
            }

            override fun onResponse(call: Call<JsonCityDetailResponse>, response: Response<JsonCityDetailResponse>) {
                response.body()?.let {
                    data.value = it.getData()
                }
            }

        })
        return data
    }
}

