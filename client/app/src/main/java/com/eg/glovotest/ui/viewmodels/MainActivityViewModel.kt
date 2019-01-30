package com.eg.glovotest.ui.viewmodels

import android.Manifest
import android.annotation.SuppressLint
import android.arch.lifecycle.LiveData
import android.arch.lifecycle.MutableLiveData
import android.arch.lifecycle.ViewModel
import android.content.Context
import android.content.pm.PackageManager
import android.location.Location
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import com.eg.glovotest.entities.City
import com.eg.glovotest.entities.CityDetails
import com.eg.glovotest.entities.Country
import com.eg.glovotest.network.repositories.GlovoDataRepository
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import com.google.android.gms.maps.model.LatLng
import javax.inject.Inject

class MainActivityViewModel @Inject constructor() : ViewModel() {

    @Inject
    lateinit var repository: GlovoDataRepository
    @Inject
    lateinit var fusedLocationClient : FusedLocationProviderClient

    lateinit var userLastLocation : Location

    var userHasLocationPermission = MutableLiveData<Boolean>()

    var countriesWithCities = MutableLiveData<MutableList<Country>>()
    var currentCityDetails = MutableLiveData<CityDetails>()

    fun checkIfUserHasLocationPermission(context: Context) {
        val permission = ContextCompat.checkSelfPermission(context,
            Manifest.permission.ACCESS_COARSE_LOCATION)
        if (permission != PackageManager.PERMISSION_GRANTED) {
            userHasLocationPermission.postValue(false)
        } else {
            userHasLocationPermission.postValue(true)
        }
    }

    @SuppressLint("MissingPermission") // We get it before checking this
    fun getUserLocation() {
        fusedLocationClient.lastLocation.addOnSuccessListener { setLastLocationAndGetWorkingAreaInformation(it) }
    }

    fun isUserIsInAWorkingArea(): Boolean {
        val userLatLang = getUserLatLng()

        for (country in countriesWithCities.value!!) {
            for (city in country.cities) {
                city.workingArea!!.isPositionInsideWorkingArea(userLatLang)
            }
        }
        return false
    }

    fun getDataFromBackend() {
        repository.getCities().observeForever {
            it?.let { cities ->
                getCountriesData(cities)
            }
        } }

    private fun getCountriesData(listOfCities : List<City>) {
        repository.getCountries().observeForever {
            it?.let { countries ->
                addCitiesToTheRespectiveCountries(listOfCities, countries)
            }
        }
    }

    private fun addCitiesToTheRespectiveCountries(listOfCities: List<City>, countries: List<Country>) {
        var countriesWithCitiesList = mutableListOf<Country>()
        for (country in countries) {
            val listOfCitiesOfACertainCountry = listOfCities.filter { city -> city.countryCode == country.code  }

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

    private fun setLastLocationAndGetWorkingAreaInformation(lastLocation: Location?) {
        lastLocation?.let {
            userLastLocation = lastLocation
            getDataFromBackend()
        }

    }

    fun getUserLatLng(): LatLng {
        return LatLng(userLastLocation.latitude, userLastLocation.longitude)
    }


}
