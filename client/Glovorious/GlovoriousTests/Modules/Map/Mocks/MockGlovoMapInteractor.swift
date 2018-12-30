//
//  MockGlovoMapInteractor.swift
//  GlovoriousTests
//
//  Created by Octo Siswardhono on 30/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation
import CoreLocation

@testable import Glovorious

class MockGlovoMapInteractor: IGlovoMapInteractor {
    var invokedCurrentLocationGetter = false
    var invokedCurrentLocationGetterCount = 0
    var stubbedCurrentLocation: CLLocationCoordinate2D!
    var currentLocation: CLLocationCoordinate2D? {
        invokedCurrentLocationGetter = true
        invokedCurrentLocationGetterCount += 1
        return stubbedCurrentLocation
    }
    var invokedSaveLocation = false
    var invokedSaveLocationCount = 0
    var invokedSaveLocationParameters: (location: CLLocation, Void)?
    var invokedSaveLocationParametersList = [(location: CLLocation, Void)]()
    func saveLocation(_ location: CLLocation) {
        invokedSaveLocation = true
        invokedSaveLocationCount += 1
        invokedSaveLocationParameters = (location, ())
        invokedSaveLocationParametersList.append((location, ()))
    }
    var invokedGetAllCountry = false
    var invokedGetAllCountryCount = 0
    func getAllCountry() {
        invokedGetAllCountry = true
        invokedGetAllCountryCount += 1
    }
    var invokedGetAllCities = false
    var invokedGetAllCitiesCount = 0
    func getAllCities() {
        invokedGetAllCities = true
        invokedGetAllCitiesCount += 1
    }
    var invokedGetCity = false
    var invokedGetCityCount = 0
    var invokedGetCityParameters: (countryCode: String, Void)?
    var invokedGetCityParametersList = [(countryCode: String, Void)]()
    func getCity(countryCode: String) {
        invokedGetCity = true
        invokedGetCityCount += 1
        invokedGetCityParameters = (countryCode, ())
        invokedGetCityParametersList.append((countryCode, ()))
    }
    var invokedGetCityDetail = false
    var invokedGetCityDetailCount = 0
    var invokedGetCityDetailParameters: (cityCode: String, Void)?
    var invokedGetCityDetailParametersList = [(cityCode: String, Void)]()
    func getCityDetail(cityCode: String) {
        invokedGetCityDetail = true
        invokedGetCityDetailCount += 1
        invokedGetCityDetailParameters = (cityCode, ())
        invokedGetCityDetailParametersList.append((cityCode, ()))
    }
}
