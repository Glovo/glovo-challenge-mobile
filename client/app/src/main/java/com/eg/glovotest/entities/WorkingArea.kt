package com.eg.glovotest.entities

import android.os.Parcelable
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.LatLngBounds
import com.google.maps.android.PolyUtil
import kotlinx.android.parcel.IgnoredOnParcel
import kotlinx.android.parcel.Parcelize

/*
 Custom class smart enough to know if a certain location is contained in itself
 Uses https://github.com/googlemaps/android-maps-utils
 */
@Parcelize
class WorkingArea(private val codedWorkingArea: List<String>) : Parcelable {

    @IgnoredOnParcel // Required to add into city's parcelize
    private val areaLatLngBounds: LatLngBounds
    private val workingAreaLatLngList: ArrayList<List<LatLng>>

    init {
        workingAreaLatLngList = decodeWorkingArea(codedWorkingArea)

        val latLngBuilder = LatLngBounds.builder()

        // We build the area to be processed by the user location
        workingAreaLatLngList.forEach { latLngList ->
            latLngList.forEach { latLng ->
                latLngBuilder.include(latLng)
            }
        }

        workingAreaLatLngList.isEmpty()
        areaLatLngBounds = latLngBuilder.build()
    }

    /**
     * Decodes the list of working area strings, into a lat n lang list.
     */
    private fun decodeWorkingArea(codedWorkingArea: List<String>): ArrayList<List<LatLng>> {
        val workingAreaLatLngList = ArrayList<List<LatLng>>()
        codedWorkingArea.forEach { workingArea ->
            if (!workingArea.isEmpty()) {
                val latLngList = PolyUtil.decode(workingArea)
                workingAreaLatLngList.add(latLngList)
            }
        }
        return workingAreaLatLngList
    }

    fun isPositionInsideWorkingArea(latLng: LatLng) : Boolean {
        return areaLatLngBounds.contains(latLng)
    }

    fun getCenterOfWorkingArea(): LatLng {
        return areaLatLngBounds.center
    }

    fun getListOfLatLngArea(): ArrayList<List<LatLng>> {
        return workingAreaLatLngList }
}