//
//  MockGlovoLocationManager.swift
//  GlovoriousTests
//
//  Created by Octo Siswardhono on 30/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation
import CoreLocation

@testable import Glovorious

class MockGlovoLocationManager: IGlovoLocationManager {
    var invokedRegister = false
    var invokedRegisterCount = 0
    var invokedRegisterParameters: (delegate: CLLocationManagerDelegate, Void)?
    var invokedRegisterParametersList = [(delegate: CLLocationManagerDelegate, Void)]()
    func register(delegate: CLLocationManagerDelegate) {
        invokedRegister = true
        invokedRegisterCount += 1
        invokedRegisterParameters = (delegate, ())
        invokedRegisterParametersList.append((delegate, ()))
    }
    var invokedRequestWhenInUseAuthorization = false
    var invokedRequestWhenInUseAuthorizationCount = 0
    func requestWhenInUseAuthorization() {
        invokedRequestWhenInUseAuthorization = true
        invokedRequestWhenInUseAuthorizationCount += 1
    }
    var invokedStartUpdatingLocation = false
    var invokedStartUpdatingLocationCount = 0
    func startUpdatingLocation() {
        invokedStartUpdatingLocation = true
        invokedStartUpdatingLocationCount += 1
    }
    var invokedStopUpdatingLocation = false
    var invokedStopUpdatingLocationCount = 0
    func stopUpdatingLocation() {
        invokedStopUpdatingLocation = true
        invokedStopUpdatingLocationCount += 1
    }
}
