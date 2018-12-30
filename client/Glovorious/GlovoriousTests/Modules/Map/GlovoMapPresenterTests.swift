//
//  GlovoMapPresenterTests.swift
//  GlovoriousTests
//
//  Created by Octo Siswardhono on 30/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import XCTest
import CoreLocation

@testable import Glovorious

class GlovoMapPresenterTests: XCTestCase {
    
    var mockView: MockGlovoMapView!
    var mockInteractor: MockGlovoMapInteractor!
    var mockRouter: MockGlovoMapRouter!
    var presenter: GlovoMapPresenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockGlovoMapView()
        mockInteractor = MockGlovoMapInteractor()
        mockRouter = MockGlovoMapRouter()
        presenter = GlovoMapPresenter(interactor: mockInteractor)
        presenter.router = mockRouter
        presenter.view = mockView
    }
    
    func testSaveLocation() {
        let dummyLoc = CLLocation.init(latitude: -6.323134, longitude: 101.14141)
        
        presenter.saveLocation(dummyLoc)
        
        XCTAssertEqual(mockInteractor.invokedSaveLocationCount, 1)
    }
    
    func testGetAllCountry() {
        presenter.getAllCountry()
        
        XCTAssertEqual(mockInteractor.invokedGetAllCountryCount, 1)
    }

    func testGetAllCities() {
        presenter.getAllCities()
        
        XCTAssertEqual(mockInteractor.invokedGetAllCitiesCount, 1)
    }
    
    func testCheckServiceAreaWhenCountryIsEmpty() {
        let countryCode = "ES"
        
        let result = presenter.checkServiceArea(countryCode)
        
        XCTAssertFalse(result)
    }
    
    func testCheckServiceAreanWhenInWorkingArea() {
        let countryCode = "Some"
        var countries:[Country] = []
        let country = Country.init(code: "Some", name: "Some Example")
        countries.append(country)
        presenter.countries = countries
        
        let result = presenter.checkServiceArea(countryCode)
        
        XCTAssertTrue(result)
    }
    
    func testGetCountryDialog() {
        mockRouter.stubbedShowCountryDialogResult = UIView()
        
        let result = presenter.getCountryDialog()
        
        XCTAssertEqual(mockRouter.invokedShowCountryDialogCount, 1)
        XCTAssertNotNil(result)
    }
    
    func testGetCityDialog() {
        mockRouter.stubbedShowCityDialogResult = UIView()
        
        let result = presenter.getCityDialog()
        
        XCTAssertEqual(mockRouter.invokedShowCityDialogCount, 1)
        XCTAssertNotNil(result)
    }
    
    func testGetCityDetail() {
        let cityCode = "Some"
        
        presenter.getCityDetail(cityCode: cityCode)
        
        XCTAssertEqual(mockInteractor.invokedGetCityDetailCount, 1)
    }
}
