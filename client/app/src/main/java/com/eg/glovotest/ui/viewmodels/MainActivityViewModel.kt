package com.eg.glovotest.ui.viewmodels

import android.arch.lifecycle.MutableLiveData
import android.arch.lifecycle.ViewModel
import com.eg.glovotest.entities.City
import com.eg.glovotest.entities.CityDetails
import com.eg.glovotest.entities.Country
import com.eg.glovotest.network.repositories.GlovoDataRepository
import javax.inject.Inject

class MainActivityViewModel @Inject constructor() : ViewModel() {

    @Inject
    lateinit var repository: GlovoDataRepository

    lateinit var countriesWithCities: MutableLiveData<MutableList<Country>>
    lateinit var citiesList: MutableLiveData<List<City>>
    lateinit var currentCityDetails: MutableLiveData<CityDetails>

    fun getCountriesAndCities() {
        citiesList.postValue(repository.getCities().value)
        var countries = repository.getCountries().value

        countries?.let {
            addCitiesToTheRespectiveCountries(countries)
        }
    }

    private fun addCitiesToTheRespectiveCountries(countries: List<Country>) {
        var countriesWithCitiesList = mutableListOf<Country>()
        for (country in countries) {
            val listOfCitiesOfACertainCountry = citiesList.value?.filter { city -> city.countryCode == country.code  }

            // We skip countries without any cities
            listOfCitiesOfACertainCountry?.let {
                countriesWithCitiesList.add(Country(country.code, country.name, listOfCitiesOfACertainCountry))
            }
        }
        countriesWithCities.postValue(countriesWithCitiesList)
    }

    fun getCityDetails(cityCode : String) {
        currentCityDetails.postValue(repository.getCityDetail(cityCode).value)
    }

}
