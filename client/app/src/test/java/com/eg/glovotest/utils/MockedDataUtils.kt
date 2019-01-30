package com.eg.glovotest.utils

import com.eg.glovotest.entities.CityDetails
import com.eg.glovotest.network.jsonmappers.JsonCityDetailResponse
import com.eg.glovotest.network.jsonmappers.JsonCityResponse
import com.eg.glovotest.network.jsonmappers.JsonCountryResponse

class MockedDataUtils {

    // Added the first city from the cities json response into here for mock purposes.

    private val cityDetails = CityDetails("CAI",
        "Cairo",
        "EG",
        "EGP",
        true,
        false,
        "Africa/Cairo",
        "EN",
        listOf(
            "c|pvDqfq}DxuAbvEt~Css@iDg{AmP{kBmgAp@"
        ))

    fun getMockedCityDetailsData() : JsonCityDetailResponse {
        return JsonCityDetailResponse(cityDetails.code, cityDetails.name, cityDetails.country_code, cityDetails.currency,
            cityDetails.enabled, cityDetails.busy, cityDetails.time_zone, cityDetails.language_code, cityDetails.working_area)
    }

    fun getMockedCityListData() : List<JsonCityResponse> {
        val cityList: MutableList<JsonCityResponse> = ArrayList()
        cityList.add(JsonCityResponse(cityDetails.code, cityDetails.name, cityDetails.country_code, cityDetails.working_area))
        return cityList
    }


    fun getMockedCountryListData() : List<JsonCountryResponse> {
        val countryList: MutableList<JsonCountryResponse> = ArrayList()
        val country = JsonCountryResponse("EG", "Egypt")
        countryList.add(country)

        return countryList
    }
}