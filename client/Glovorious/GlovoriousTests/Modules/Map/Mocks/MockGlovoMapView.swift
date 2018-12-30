//
//  MockGlovoMapView.swift
//  GlovoriousTests
//
//  Created by Octo Siswardhono on 30/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation

@testable import Glovorious

class MockGlovoMapView: IGlovoMapView {
    var invokedGecode = false
    var invokedGecodeCount = 0
    var invokedGecodeParameters: (country: [Country], Void)?
    var invokedGecodeParametersList = [(country: [Country], Void)]()
    func gecode(withCountry country: [Country]) {
        invokedGecode = true
        invokedGecodeCount += 1
        invokedGecodeParameters = (country, ())
        invokedGecodeParametersList.append((country, ()))
    }
    var invokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (error: NSError, Void)?
    var invokedShowErrorParametersList = [(error: NSError, Void)]()
    func showError(error: NSError) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (error, ())
        invokedShowErrorParametersList.append((error, ()))
    }
    var invokedShowCountryDialog = false
    var invokedShowCountryDialogCount = 0
    func showCountryDialog() {
        invokedShowCountryDialog = true
        invokedShowCountryDialogCount += 1
    }
    var invokedShowCityDialog = false
    var invokedShowCityDialogCount = 0
    func showCityDialog() {
        invokedShowCityDialog = true
        invokedShowCityDialogCount += 1
    }
    var invokedShowWorkingArea = false
    var invokedShowWorkingAreaCount = 0
    var invokedShowWorkingAreaParameters: (city: City, Void)?
    var invokedShowWorkingAreaParametersList = [(city: City, Void)]()
    func showWorkingArea(city: City) {
        invokedShowWorkingArea = true
        invokedShowWorkingAreaCount += 1
        invokedShowWorkingAreaParameters = (city, ())
        invokedShowWorkingAreaParametersList.append((city, ()))
    }
    var invokedGetAllWorkingArea = false
    var invokedGetAllWorkingAreaCount = 0
    func getAllWorkingArea() {
        invokedGetAllWorkingArea = true
        invokedGetAllWorkingAreaCount += 1
    }
}
