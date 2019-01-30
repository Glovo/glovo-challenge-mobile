package com.eg.glovotest.entities

import android.os.Parcelable
import com.google.android.gms.maps.model.MarkerOptions
import kotlinx.android.parcel.Parcelize

@Parcelize
data class MapMarker(
    val city: City,
    val markerOptions: MarkerOptions)
    : Parcelable