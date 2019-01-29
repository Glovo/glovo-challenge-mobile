package com.eg.glovotest.viewmodels

class MainActivityViewModelTest {

    // Test used for dev purposes

//    @get:Rule
//    var rule: TestRule = InstantTaskExecutorRule()
//
//    private val viewModel = MapActivityViewModel()
//    private val mockApi: GlovoServiceAPI = mock()
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
//        viewModel.getDataFromBackend()
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
