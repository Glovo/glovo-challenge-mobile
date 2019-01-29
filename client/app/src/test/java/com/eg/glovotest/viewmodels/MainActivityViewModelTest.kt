package com.eg.glovotest.viewmodels

import org.junit.Test

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.eg.glovotest.utils.MockedDataUtils
import com.eg.glovotest.network.services.GlovoService
import com.eg.glovotest.ui.viewmodels.MainActivityViewModel
import com.nhaarman.mockitokotlin2.any
import com.nhaarman.mockitokotlin2.mock
import com.nhaarman.mockitokotlin2.whenever
import org.junit.Assert.*
import org.junit.Before
import org.junit.Rule
import org.junit.rules.TestRule
import retrofit2.Response
import kotlinx.coroutines.runBlocking

class MainActivityViewModelTest {

    // Test used for dev purposes

//    @get:Rule
//    var rule: TestRule = InstantTaskExecutorRule()
//
//    private val viewModel = MainActivityViewModel()
//    private val mockApi: GlovoService = mock()
//    private val mockedDataUtils = MockedDataUtils()
//
//    @Before
//    fun testSetup() {
//        setMockData()
//    }
//
//    private fun setMockData() {
//        val jsonCitiesResponse = Response.success(mockedDataUtils.getMockedCityListData())
//        val jsonCityDetailsResponse = Response.success(mockedDataUtils.getMockedCityDetailsData())
//        val jsonCountriesResponse = Response.success(mockedDataUtils.getMockedCountryListData())
//
//        whenever(mockApi.getCitiesList().execute()).thenReturn(jsonCitiesResponse)
//        whenever(mockApi.getCityDetails(any()).execute()).thenReturn(jsonCityDetailsResponse)
//        whenever(mockApi.getCountriesList().execute()).thenReturn(jsonCountriesResponse)
//    }
//
//    @Test fun test_getCountriesWithCity_returns_data() = runBlocking {
//        viewModel.getCountriesAndCities()
//
//        val countriesList = viewModel.countriesWithCities.value
//
//        assertFalse(countriesList!!.isEmpty())
//
//        countriesList.forEach { country ->
//            country.cities.forEach { city ->
//                assertEquals(country.code, city.countryCode)
//            }
//        }
//    }

}
