package com.eg.glovotest.network.jsonmappers

import com.eg.glovotest.entities.City
import com.eg.glovotest.entities.WorkingArea
import com.google.gson.annotations.SerializedName

data class JsonCityResponse  (
        @SerializedName("code") val code : String,
        @SerializedName ("name") val name : String,
        @SerializedName ("country_code") val countryCode : String,
        @SerializedName("working_area") val undecodedWorkingArea : List<String>)
    : JsonResponseData {

    override fun getData(): City {
       return City(code, name, countryCode, WorkingArea(undecodedWorkingArea))
    }
}