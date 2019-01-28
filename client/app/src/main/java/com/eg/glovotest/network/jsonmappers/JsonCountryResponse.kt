package com.eg.glovotest.network.jsonmappers

import com.eg.glovotest.network.entities.Country
import com.google.gson.annotations.SerializedName

data class JsonCountryResponse  (
        @SerializedName("code") val code : String,
        @SerializedName ("name") val name : String)
    : JsonResponseData {

    override fun getData(): Country {
       return Country(code, name)
    }
}