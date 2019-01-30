package com.eg.glovotest.entities

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class CountriesAndCitiesWrapper (
    val countries: List<Country>
) : Parcelable

{
    fun getPlainListOfCountriesAndCities(): ArrayList<Any> {
        val plainListOfCountriesAndCities = arrayListOf<Any>()

        for (country in countries) {
            plainListOfCountriesAndCities.add(country)

            for (city in country.cities){
                plainListOfCountriesAndCities.add(city)
            }
        }

        return plainListOfCountriesAndCities
    }
}