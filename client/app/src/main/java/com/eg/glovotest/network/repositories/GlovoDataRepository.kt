package com.eg.glovotest.network.repositories

import android.arch.lifecycle.LiveData
import com.eg.glovotest.entities.City
import com.eg.glovotest.entities.CityDetails
import com.eg.glovotest.entities.Country
import javax.inject.Singleton

@Singleton
interface  GlovoDataRepository {

    fun getCountries(): LiveData<List<Country>>
    fun getCities(): LiveData<List<City>>
    fun getCityDetail(cityId : String): LiveData<CityDetails>

}
