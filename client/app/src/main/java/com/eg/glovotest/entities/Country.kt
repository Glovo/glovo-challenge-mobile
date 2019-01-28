package com.eg.glovotest.network.entities

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Country (
    val code: String,
    val name: String
) : Parcelable