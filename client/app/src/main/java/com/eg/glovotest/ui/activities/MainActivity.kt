package com.eg.glovotest.ui.activities

import android.Manifest
import android.arch.lifecycle.Observer
import android.arch.lifecycle.ViewModelProviders
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.ActivityCompat
import android.widget.Toast
import com.eg.glovotest.R
import com.eg.glovotest.daggerInjection.ViewModelFactory
import com.eg.glovotest.ui.viewmodels.MainActivityViewModel
import dagger.android.AndroidInjection
import javax.inject.Inject
import android.content.pm.PackageManager
import android.support.v4.content.ContextCompat
import android.view.View
import com.eg.glovotest.Constants
import com.eg.glovotest.entities.City
import com.eg.glovotest.entities.CountriesAndCitiesWrapper
import com.eg.glovotest.ui.fragments.CityPickerFragment
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.Marker
import com.google.android.gms.maps.model.PolygonOptions
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity(), CityPickerFragment.OnCityListFragmentInteractionListener, OnMapReadyCallback,
    GoogleMap.OnCameraMoveListener, GoogleMap.OnMarkerClickListener {

    @Inject
    lateinit var viewModelFactory: ViewModelFactory
    private lateinit var mainActivityViewModel: MainActivityViewModel

    private lateinit var mMap: GoogleMap

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        initViewModel()
        initMap()

    }

    private fun initMap() {
        val mapFragment = supportFragmentManager
            .findFragmentById(R.id.map) as SupportMapFragment
        mapFragment.getMapAsync(this)
    }

    private fun initViewModel() {
        mainActivityViewModel = ViewModelProviders.of(this, viewModelFactory)[MainActivityViewModel::class.java]
        mainActivityViewModel.userHasLocationPermission.observe(this, Observer { updateViewBasedOnPermission(it!!) })
        mainActivityViewModel.countriesWithCities.observe(this, Observer { checkIfUserIsInAWorkingArea() })
        mainActivityViewModel.checkIfUserHasLocationPermission(this)
    }

    private fun checkIfUserIsInAWorkingArea() {
        if (mainActivityViewModel.isUserIsInAWorkingArea()) {
            showMapFragment(mainActivityViewModel.getUserLatLng())
        } else {
            showPickCityFragment()
        }
    }

    private fun updateViewBasedOnPermission(hasLocalizationPermission: Boolean) {
        if (hasLocalizationPermission) {
            mainActivityViewModel.getUserLocation()
        } else {
            showEnableLocationPermissionPopUp()
        }
    }

    private fun showPickCityFragment() {
        vMainActivityProgressBar.visibility = View.GONE
        vCityPickerFragmentContainer.visibility = View.VISIBLE
        val wrappedCountriesAndCities =
            CountriesAndCitiesWrapper(mainActivityViewModel.countriesWithCities.value!!.toList())
        val cityPickerFragment = CityPickerFragment.newInstance(wrappedCountriesAndCities)

        supportFragmentManager.beginTransaction()
            .add(R.id.vCityPickerFragmentContainer, cityPickerFragment).commit()
    }

    private fun showMapFragment(centerOfWorkingArea: LatLng) {
        vCityPickerFragmentContainer.visibility = View.GONE
        drawAllTheWorkingAreasOnTheMap()
        mMap.moveCamera(CameraUpdateFactory.newLatLng(centerOfWorkingArea))
        mMap.moveCamera(CameraUpdateFactory.zoomTo(10f))
    }

    private fun showEnableLocationPermissionPopUp() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
            Constants.LOCATION_CALLBACK_CODE
        )
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>, grantResults: IntArray
    ) {
        when (requestCode) {
            Constants.LOCATION_CALLBACK_CODE -> {
                // If request is cancelled, the result arrays are empty.
                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    mainActivityViewModel.getUserLocation()
                } else {
                    Toast.makeText(this, "Please Accept The Permission", Toast.LENGTH_SHORT).show()
                }
                return
            }
        }
    }

    override fun onCityPicked(city: City) {
        Toast.makeText(this, "Selected City " + city.name, Toast.LENGTH_SHORT).show()
        showMapFragment(city.workingArea!!.getCenterOfWorkingArea())
    }

    /**
     *  Map Related configuration
     */

    override fun onMapReady(googleMap: GoogleMap) {
        mMap = googleMap
        mMap.uiSettings.isZoomControlsEnabled = true
        mMap.uiSettings.isMyLocationButtonEnabled = true
        mMap.setOnCameraMoveListener(this)
        mMap.setOnMarkerClickListener(this)
    }

    override fun onCameraMove() {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun onMarkerClick(p0: Marker?): Boolean {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    private fun drawAllTheWorkingAreasOnTheMap() {
        mainActivityViewModel.countriesWithCities.value?.forEach {
            it.cities.forEach {
                it.workingArea?.getListOfLatLngArea()?.forEach { latLngList ->
                    mMap.addPolygon(
                        PolygonOptions()
                            .addAll(latLngList)
                            .fillColor(ContextCompat.getColor(this, R.color.colorAccentTransparent))
                    )
                }
            }

        }
    }


}
