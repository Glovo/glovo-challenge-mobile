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
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun getCityDetail(cityId: String): LiveData<CityDetails> {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }
    
}

