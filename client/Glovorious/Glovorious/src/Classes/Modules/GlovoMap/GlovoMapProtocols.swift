//
//  GlovoMapProtocols.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 22/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import UIKit
import CoreLocation

protocol IGlovoMapView: class {
    func gecode(withCountry country: [Country])
    func showError(error: NSError)
    func showCountryDialog()
    func showCityDialog()
    func showWorkingArea(city: City)
    func getAllWorkingArea()
}

protocol IGlovoMapPresenter: class {
    var currentLocation:CLLocationCoordinate2D? { get }
    var countries: [Country]? { get set }
    var cities: [City]? { get set }
    var selectedCity: City? {get set}
    func saveLocation(_ location: CLLocation)
    func getAllCountry()
    func getAllCities()
    func checkServiceArea(_ countryCode: String) -> Bool
    func getCountryDialog() -> UIView
    func getCity(countryCode: String)
    func getCityDialog() -> UIView
    func getCityDetail(cityCode: String)
}

protocol IGlovoMapInteractor: class {
    var currentLocation: CLLocationCoordinate2D? { get }
    func saveLocation(_ location: CLLocation)
    func getAllCountry()
    func getAllCities()
    func getCity(countryCode: String)
    func getCityDetail(cityCode: String)
}

protocol IGlovoMapRouter: class {
    func generateModule() -> UIViewController
    func showCountryDialog() -> UIView
    func showCityDialog() -> UIView
}

protocol IGlovoMapInteractorDelegate:class {
    func glovoMapInteractorDidSuccessGetAllCountry(_ countries: [Country])
    func glovoMapInteractorDidFailGetAllCountry(error: NSError)
    func glovoMapInteractorDidSuccessGetAllCities(_ cities: [City])
    func glovoMapInteractorDidFailGetAllCities(error: NSError)
    func glovoMapInteractorDidSuccessGetCity(_ cities: [City])
    func glovoMapInteractorDidFailGetCity(error: NSError)
    func glovoMapInteractorDidSuccessGetCityByCityId(_ city: City)
    func glovoMapInteractorDidFailGetCityByCityId(error: NSError)

}
