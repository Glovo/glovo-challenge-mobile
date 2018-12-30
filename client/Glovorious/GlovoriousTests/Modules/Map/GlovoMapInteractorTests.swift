//
//  GlovoMapInteractorTests.swift
//  GlovoriousTests
//
//  Created by Octo Siswardhono on 30/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import XCTest
import CoreLocation

@testable import Glovorious

class GlovoMapInteractorTests: XCTestCase {
    var mockDelegate: MockGlovoMapInteractorDelegate!
    var mockDataManager: MockGlovoDataManager!
    var mockService: MockGlovoServices!
    var interactor: GlovoMapInteractor!
    
    override func setUp() {
        mockDelegate = MockGlovoMapInteractorDelegate()
        mockDataManager = MockGlovoDataManager()
        mockService = MockGlovoServices()
        interactor = GlovoMapInteractor()
        interactor.dataManager = mockDataManager
        interactor.service = mockService
        interactor.delegate = mockDelegate
    }
    
    func testSaveLocation() {
        let dummyLoc = CLLocation.init(latitude: -6.323134, longitude: 101.14141)
        
        interactor.saveLocation(dummyLoc)
        
        XCTAssertEqual(mockDataManager.invokedSaveCurrentLocationCount, 1)
    }
    
    func testGetAllCountry() {
        var countries:[Country] = []
        let country = Country.init(code: "Some", name: "Some Example")
        countries.append(country)
        mockService.stubbedGetAllCountrySuccessResult = (countries, ())
        
        interactor.getAllCountry()
        
        XCTAssertEqual(mockService.invokedGetAllCountryCount, 1)
        XCTAssertNotNil(mockDelegate.invokedGlovoMapInteractorDidSuccessGetAllCountryParameters)
        if let params = mockDelegate.invokedGlovoMapInteractorDidSuccessGetAllCountryParameters {
            XCTAssertEqual(params.countries.first!.code, countries.first!.code)
        }
    }

    func testGetAllCities() {
        var cities:[City] = []
        let city = City.init(workingArea: [], code: "Some City", name: "Some Example", countryCode: "Some Country", desc: "", enabled: false, currency: "IDR", timezone: "", busy: false, languageCode: "ID")
        cities.append(city)
        mockService.stubbedGetAllCitySuccessResult = (cities, ())
        
        interactor.getAllCities()
        
        XCTAssertEqual(mockService.invokedGetAllCityCount, 1)
        XCTAssertNotNil(mockDelegate.invokedGlovoMapInteractorDidSuccessGetAllCitiesParameters)
        if let params = mockDelegate.invokedGlovoMapInteractorDidSuccessGetAllCitiesParameters {
            XCTAssertEqual(params.cities.first!.code, cities.first!.code)
        }
    }
    
    func testGetCityWhenCountryCodeIsNotNil() {
        let countryCode = "Some Country"
        var cities:[City] = []
        let city = City.init(workingArea: [], code: "Some City", name: "Some Example", countryCode: "Some Country", desc: "", enabled: false, currency: "IDR", timezone: "", busy: false, languageCode: "ID")
        cities.append(city)
        mockService.stubbedGetAllCitySuccessResult = (cities, ())
       
        interactor.getCity(countryCode: countryCode)
        
        XCTAssertNotNil(mockDelegate.invokedGlovoMapInteractorDidSuccessGetCityParameters)
        if let params = mockDelegate.invokedGlovoMapInteractorDidSuccessGetCityParameters {
            XCTAssertEqual(params.cities.first!.code, cities.first!.code)
        }
    }
    
    func testGetCityDetailWhenCityCodeIsNotNil() {
        let cityCode = "Some City"
        var cities:[City] = []
        let city = City.init(workingArea: ["abc"], code: "Some City", name: "Some Example", countryCode: "Some Country", desc: "", enabled: false, currency: "IDR", timezone: "", busy: false, languageCode: "ID")
        cities.append(city)
        mockService.stubbedGetCitySuccessResult = (city, ())
        
        interactor.getCityDetail(cityCode: cityCode)
        
        XCTAssertNotNil(mockDelegate.invokedGlovoMapInteractorDidSuccessGetCityByCityIdParameters)
        if let params = mockDelegate.invokedGlovoMapInteractorDidSuccessGetCityByCityIdParameters {
            XCTAssertEqual(params.city.code, cities.first!.code)
        }
    }
}
