//
//  MockGlovoServices.swift
//  GlovoriousTests
//
//  Created by Octo Siswardhono on 30/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation

@testable import Glovorious

class MockGlovoServices: IGlovoService {
    var invokedGetAllCountry = false
    var invokedGetAllCountryCount = 0
    var stubbedGetAllCountrySuccessResult: ([Country], Void)?
    var stubbedGetAllCountryFailureResult: (NSError, Void)?
    func getAllCountry(success: @escaping([Country]) -> Void, failure: @escaping (NSError) -> Void) {
        invokedGetAllCountry = true
        invokedGetAllCountryCount += 1
        if let result = stubbedGetAllCountrySuccessResult {
            success(result.0)
        }
        if let result = stubbedGetAllCountryFailureResult {
            failure(result.0)
        }
    }
    var invokedGetAllCity = false
    var invokedGetAllCityCount = 0
    var stubbedGetAllCitySuccessResult: ([City], Void)?
    var stubbedGetAllCityFailureResult: (NSError, Void)?
    func getAllCity(success: @escaping([City]) -> Void, failure: @escaping(NSError) -> Void) {
        invokedGetAllCity = true
        invokedGetAllCityCount += 1
        if let result = stubbedGetAllCitySuccessResult {
            success(result.0)
        }
        if let result = stubbedGetAllCityFailureResult {
            failure(result.0)
        }
    }
    var invokedGetCity = false
    var invokedGetCityCount = 0
    var invokedGetCityParameters: (cityCode: String, Void)?
    var invokedGetCityParametersList = [(cityCode: String, Void)]()
    var stubbedGetCitySuccessResult: (City, Void)?
    var stubbedGetCityFailureResult: (NSError, Void)?
    func getCity(cityCode: String, success: @escaping(City) -> Void, failure: @escaping(NSError) -> Void) {
        invokedGetCity = true
        invokedGetCityCount += 1
        invokedGetCityParameters = (cityCode, ())
        invokedGetCityParametersList.append((cityCode, ()))
        if let result = stubbedGetCitySuccessResult {
            success(result.0)
        }
        if let result = stubbedGetCityFailureResult {
            failure(result.0)
        }
    }
}
