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
import android.view.View
import com.eg.glovotest.Constants
import com.eg.glovotest.entities.City
import com.eg.glovotest.entities.CountriesAndCitiesWrapper
import com.eg.glovotest.ui.fragments.CityPickerFragment
import com.google.android.gms.maps.model.LatLng
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity(), CityPickerFragment.OnCityListFragmentInteractionListener {

    @Inject
    lateinit var viewModelFactory: ViewModelFactory
    private lateinit var mainActivityViewModel : MainActivityViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        initViewModel()
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
        if(hasLocalizationPermission) {
            mainActivityViewModel.getUserLocation()
        }
        else {
            showEnableLocationPermissionPopUp()
        }
    }

    private fun showPickCityFragment() {
        vMainActivityProgressBar.visibility = View.GONE
        vCityPickerFragmentContainer.visibility = View.VISIBLE
        val wrappedCountriesAndCities = CountriesAndCitiesWrapper(mainActivityViewModel.countriesWithCities.value!!.toList())
        val cityPickerFragment = CityPickerFragment.newInstance(wrappedCountriesAndCities)

        supportFragmentManager.beginTransaction()
            .add(R.id.vCityPickerFragmentContainer, cityPickerFragment).commit()
    }

    private fun showMapFragment(centerOfWorkingArea: LatLng) {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    private fun showEnableLocationPermissionPopUp() {
        ActivityCompat.requestPermissions(this,
            arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
            Constants.LOCATION_CALLBACK_CODE)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>, grantResults: IntArray) {
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
        Toast.makeText(this, "Selected City "+city.name, Toast.LENGTH_SHORT).show()
//        mainActivityViewModel.getCityDetails(city.code)
//        showMapFragment(city.workingArea!!.getCenterOfWorkingArea())
    }
}
