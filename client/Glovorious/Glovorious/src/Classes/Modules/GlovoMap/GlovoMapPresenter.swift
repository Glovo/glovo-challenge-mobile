//
//  GlovoMapPresenter.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 22/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import UIKit
import CoreLocation

class GlovoMapPresenter: IGlovoMapPresenter {
    
    weak var view: IGlovoMapView?
    let interactor: IGlovoMapInteractor
    var router: IGlovoMapRouter!
    
    var countries: [Country]?
    var cities: [City]?
    var selectedCity: City?
    
    var currentLocation: CLLocationCoordinate2D? {
        return interactor.currentLocation
    }
    
    init(interactor: IGlovoMapInteractor) {
        self.interactor = interactor
    }
    
    func saveLocation(_ location: CLLocation) {
        interactor.saveLocation(location)
    }
    
    func getAllCountry() {
        interactor.getAllCountry()
    }
    
    func getAllCities() {
        interactor.getAllCities()
    }
    
    func checkServiceArea(_ countryCode: String) -> Bool {
        guard let countries = self.countries else {
            return false
        }
        for country in countries {
            if countryCode == country.code {
                return true
            }
        }
       return false
    }
    
    func getCountryDialog() -> UIView {
        return router.showCountryDialog()
    }
    
    func getCity(countryCode: String) {
        interactor.getCity(countryCode: countryCode)
    }
    
    func getCityDialog() -> UIView {
        return router.showCityDialog()
    }
    
    func getCityDetail(cityCode: String) {
        interactor.getCityDetail(cityCode: cityCode)
    }
    
}

extension GlovoMapPresenter: IGlovoMapInteractorDelegate {
    
    func glovoMapInteractorDidSuccessGetAllCountry(_ countries: [Country]) {
        self.countries = countries
        view?.gecode(withCountry: countries)
    }
    
    func glovoMapInteractorDidFailGetAllCountry(error: NSError) {
        view?.showError(error: error)
    }
    
    func glovoMapInteractorDidSuccessGetAllCities(_ cities: [City]) {
        self.cities = cities
        view?.getAllWorkingArea()
    }
    
    func glovoMapInteractorDidFailGetAllCities(error: NSError) {
        view?.showError(error: error)
    }
    func glovoMapInteractorDidSuccessGetCity(_ cities: [City]) {
        self.cities = cities
        view?.showCityDialog()
    }
    
    func glovoMapInteractorDidFailGetCity(error: NSError) {
        view?.showError(error: error)
    }
    
    func glovoMapInteractorDidSuccessGetCityByCityId(_ city: City) {
        print("city:")
        dump(city)
        view?.showWorkingArea(city: city)
    }
    
    func glovoMapInteractorDidFailGetCityByCityId(error: NSError) {
        view?.showError(error: error)
    }
}
