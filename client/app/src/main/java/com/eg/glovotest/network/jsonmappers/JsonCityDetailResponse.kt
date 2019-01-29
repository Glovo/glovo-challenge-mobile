package com.eg.glovotest.network.jsonmappers

import com.eg.glovotest.entities.CityDetails
import com.google.gson.annotations.SerializedName

data class JsonCityDetailResponse  (
        @SerializedName("code") val code : String,
        @SerializedName("name") val name : String,
        @SerializedName("country_code") val countryCode : String,
        @SerializedName("currency") val currency : String,
        @SerializedName("enabled") val enabled : Boolean,
        @SerializedName("busy") val busy : Boolean,
        @SerializedName("time_zone") val timeZone : String,
        @SerializedName("language_code") val languageCode : String,
        @SerializedName ("working_area") val workingArea : List<String>)
    : JsonResponseData {

    override fun getData(): CityDetails {
       return CityDetails(code, name, countryCode, currency, enabled, busy, timeZone, languageCode, workingArea)
    }
}