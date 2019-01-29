package com.eg.glovotest.entities

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class City (
    val code: String,
    val name: String,
    val countryCode: String
) : Parcelable