//
//  MockGlovoMapInteractorDelegate.swift
//  GlovoriousTests
//
//  Created by Octo Siswardhono on 30/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation

@testable import Glovorious

class MockGlovoMapInteractorDelegate: IGlovoMapInteractorDelegate {
    var invokedGlovoMapInteractorDidSuccessGetAllCountry = false
    var invokedGlovoMapInteractorDidSuccessGetAllCountryCount = 0
    var invokedGlovoMapInteractorDidSuccessGetAllCountryParameters: (countries: [Country], Void)?
    var invokedGlovoMapInteractorDidSuccessGetAllCountryParametersList = [(countries: [Country], Void)]()
    func glovoMapInteractorDidSuccessGetAllCountry(_ countries: [Country]) {
        invokedGlovoMapInteractorDidSuccessGetAllCountry = true
        invokedGlovoMapInteractorDidSuccessGetAllCountryCount += 1
        invokedGlovoMapInteractorDidSuccessGetAllCountryParameters = (countries, ())
        invokedGlovoMapInteractorDidSuccessGetAllCountryParametersList.append((countries, ()))
    }
    var invokedGlovoMapInteractorDidFailGetAllCountry = false
    var invokedGlovoMapInteractorDidFailGetAllCountryCount = 0
    var invokedGlovoMapInteractorDidFailGetAllCountryParameters: (error: NSError, Void)?
    var invokedGlovoMapInteractorDidFailGetAllCountryParametersList = [(error: NSError, Void)]()
    func glovoMapInteractorDidFailGetAllCountry(error: NSError) {
        invokedGlovoMapInteractorDidFailGetAllCountry = true
        invokedGlovoMapInteractorDidFailGetAllCountryCount += 1
        invokedGlovoMapInteractorDidFailGetAllCountryParameters = (error, ())
        invokedGlovoMapInteractorDidFailGetAllCountryParametersList.append((error, ()))
    }
    var invokedGlovoMapInteractorDidSuccessGetAllCities = false
    var invokedGlovoMapInteractorDidSuccessGetAllCitiesCount = 0
    var invokedGlovoMapInteractorDidSuccessGetAllCitiesParameters: (cities: [City], Void)?
    var invokedGlovoMapInteractorDidSuccessGetAllCitiesParametersList = [(cities: [City], Void)]()
    func glovoMapInteractorDidSuccessGetAllCities(_ cities: [City]) {
        invokedGlovoMapInteractorDidSuccessGetAllCities = true
        invokedGlovoMapInteractorDidSuccessGetAllCitiesCount += 1
        invokedGlovoMapInteractorDidSuccessGetAllCitiesParameters = (cities, ())
        invokedGlovoMapInteractorDidSuccessGetAllCitiesParametersList.append((cities, ()))
    }
    var invokedGlovoMapInteractorDidFailGetAllCities = false
    var invokedGlovoMapInteractorDidFailGetAllCitiesCount = 0
    var invokedGlovoMapInteractorDidFailGetAllCitiesParameters: (error: NSError, Void)?
    var invokedGlovoMapInteractorDidFailGetAllCitiesParametersList = [(error: NSError, Void)]()
    func glovoMapInteractorDidFailGetAllCities(error: NSError) {
        invokedGlovoMapInteractorDidFailGetAllCities = true
        invokedGlovoMapInteractorDidFailGetAllCitiesCount += 1
        invokedGlovoMapInteractorDidFailGetAllCitiesParameters = (error, ())
        invokedGlovoMapInteractorDidFailGetAllCitiesParametersList.append((error, ()))
    }
    var invokedGlovoMapInteractorDidSuccessGetCity = false
    var invokedGlovoMapInteractorDidSuccessGetCityCount = 0
    var invokedGlovoMapInteractorDidSuccessGetCityParameters: (cities: [City], Void)?
    var invokedGlovoMapInteractorDidSuccessGetCityParametersList = [(cities: [City], Void)]()
    func glovoMapInteractorDidSuccessGetCity(_ cities: [City]) {
        invokedGlovoMapInteractorDidSuccessGetCity = true
        invokedGlovoMapInteractorDidSuccessGetCityCount += 1
        invokedGlovoMapInteractorDidSuccessGetCityParameters = (cities, ())
        invokedGlovoMapInteractorDidSuccessGetCityParametersList.append((cities, ()))
    }
    var invokedGlovoMapInteractorDidFailGetCity = false
    var invokedGlovoMapInteractorDidFailGetCityCount = 0
    var invokedGlovoMapInteractorDidFailGetCityParameters: (error: NSError, Void)?
    var invokedGlovoMapInteractorDidFailGetCityParametersList = [(error: NSError, Void)]()
    func glovoMapInteractorDidFailGetCity(error: NSError) {
        invokedGlovoMapInteractorDidFailGetCity = true
        invokedGlovoMapInteractorDidFailGetCityCount += 1
        invokedGlovoMapInteractorDidFailGetCityParameters = (error, ())
        invokedGlovoMapInteractorDidFailGetCityParametersList.append((error, ()))
    }
    var invokedGlovoMapInteractorDidSuccessGetCityByCityId = false
    var invokedGlovoMapInteractorDidSuccessGetCityByCityIdCount = 0
    var invokedGlovoMapInteractorDidSuccessGetCityByCityIdParameters: (city: City, Void)?
    var invokedGlovoMapInteractorDidSuccessGetCityByCityIdParametersList = [(city: City, Void)]()
    func glovoMapInteractorDidSuccessGetCityByCityId(_ city: City) {
        invokedGlovoMapInteractorDidSuccessGetCityByCityId = true
        invokedGlovoMapInteractorDidSuccessGetCityByCityIdCount += 1
        invokedGlovoMapInteractorDidSuccessGetCityByCityIdParameters = (city, ())
        invokedGlovoMapInteractorDidSuccessGetCityByCityIdParametersList.append((city, ()))
    }
    var invokedGlovoMapInteractorDidFailGetCityByCityId = false
    var invokedGlovoMapInteractorDidFailGetCityByCityIdCount = 0
    var invokedGlovoMapInteractorDidFailGetCityByCityIdParameters: (error: NSError, Void)?
    var invokedGlovoMapInteractorDidFailGetCityByCityIdParametersList = [(error: NSError, Void)]()
    func glovoMapInteractorDidFailGetCityByCityId(error: NSError) {
        invokedGlovoMapInteractorDidFailGetCityByCityId = true
        invokedGlovoMapInteractorDidFailGetCityByCityIdCount += 1
        invokedGlovoMapInteractorDidFailGetCityByCityIdParameters = (error, ())
        invokedGlovoMapInteractorDidFailGetCityByCityIdParametersList.append((error, ()))
    }
}
