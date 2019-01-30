package com.eg.glovotest.entities

import android.os.Parcelable
import com.eg.glovotest.entities.City
import kotlinx.android.parcel.Parcelize

@Parcelize
data class CountriesAndCitiesWrapper (
    val countries: List<Country>
) : Parcelable

{
    fun getPlainListOfCountriesAndCities(): ArrayList<Any> {
        var plainListOfCountriesAndCities = arrayListOf<Any>()

        for (country in countries) {
            plainListOfCountriesAndCities.add(country)

            for (city in country.cities){
                plainListOfCountriesAndCities.add(city)
            }
        }

        return plainListOfCountriesAndCities
    }
}