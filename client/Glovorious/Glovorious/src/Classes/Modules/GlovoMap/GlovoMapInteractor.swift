//
//  GlovoMapInteractor.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 22/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation
import CoreLocation

class GlovoMapInteractor: IGlovoMapInteractor {
    
    weak var delegate: IGlovoMapInteractorDelegate?
    var dataManager: IGlovoDataManager!
    var service: IGlovoService!
    
    var currentLocation: CLLocationCoordinate2D? {
        return dataManager.loadLastLocation()
    }
    
    func saveLocation(_ location: CLLocation) {
        dataManager.saveCurrentLocation(location.coordinate)
    }
    
    func getAllCountry() {
        service.getAllCountry(success: { [weak self] (countries) in
            self?.delegate?.glovoMapInteractorDidSuccessGetAllCountry(countries)
        }, failure: {[weak self] (error) in
            self?.delegate?.glovoMapInteractorDidFailGetAllCountry(error: error)
        })
    }
    
    func getAllCities() {
        service.getAllCity(success: { [weak self] (cities) in
            self?.delegate?.glovoMapInteractorDidSuccessGetAllCities(cities)
            }, failure: {[weak self] (error) in
                self?.delegate?.glovoMapInteractorDidFailGetAllCities(error: error)
        })
    }
    
    func getCity(countryCode: String) {
        service.getAllCity(success: { [weak self] (cities) in
            self?.delegate?.glovoMapInteractorDidSuccessGetCity(cities.filter{$0.countryCode == countryCode})
        }, failure: {[weak self] (error) in
            self?.delegate?.glovoMapInteractorDidFailGetCity(error: error)
        })
    }
    
    func getCityDetail(cityCode: String) {
        service.getCity(cityCode: cityCode, success: { [weak self] (city) in
            self?.delegate?.glovoMapInteractorDidSuccessGetCityByCityId(city)
        }, failure: {[weak self] (error) in
            self?.delegate?.glovoMapInteractorDidFailGetCityByCityId(error: error)
        })
    }
}
