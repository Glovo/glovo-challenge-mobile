package com.eg.glovotest.entities

import android.os.Parcelable
import com.eg.glovotest.entities.City
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Country (
    val code: String,
    val name: String,
    val cities: List<City>
) : Parcelable