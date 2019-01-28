package com.eg.glovotest.network.jsonmappers

import com.eg.glovotest.network.entities.City
import com.google.gson.annotations.SerializedName

data class JsonCityResponse  (
        @SerializedName("code") val code : String,
        @SerializedName ("name") val name : String)
    : JsonResponseData {

    override fun getData(): City {
       return City(code, name)
    }
}