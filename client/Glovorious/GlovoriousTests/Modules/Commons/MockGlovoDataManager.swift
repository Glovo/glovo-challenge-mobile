//
//  MockGlovoDataManager.swift
//  GlovoriousTests
//
//  Created by Octo Siswardhono on 30/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation
import CoreLocation

@testable import Glovorious

class MockGlovoDataManager: IGlovoDataManager {
    var invokedLoadLastLocation = false
    var invokedLoadLastLocationCount = 0
    var stubbedLoadLastLocationResult: CLLocationCoordinate2D!
    func loadLastLocation() -> CLLocationCoordinate2D? {
        invokedLoadLastLocation = true
        invokedLoadLastLocationCount += 1
        return stubbedLoadLastLocationResult
    }
    var invokedSaveCurrentLocation = false
    var invokedSaveCurrentLocationCount = 0
    var invokedSaveCurrentLocationParameters: (location: CLLocationCoordinate2D, Void)?
    var invokedSaveCurrentLocationParametersList = [(location: CLLocationCoordinate2D, Void)]()
    func saveCurrentLocation(_ location: CLLocationCoordinate2D) {
        invokedSaveCurrentLocation = true
        invokedSaveCurrentLocationCount += 1
        invokedSaveCurrentLocationParameters = (location, ())
        invokedSaveCurrentLocationParametersList.append((location, ()))
    }
}
