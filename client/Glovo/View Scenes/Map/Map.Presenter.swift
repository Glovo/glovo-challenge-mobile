//
//  Map.Presenter.swift
//  Glovo
//
//  Created by Eugène Peschard on 11/03/2019.
//  Copyright © 2019 pesch.app. All rights reserved.
//

import Foundation
import GoogleMaps

protocol MapPresenter: class {
    
    var router: MapRouter? { get set }
    var interactor: MapInteractor? { get set }
    var view: MapViewController? { get set }
    
    var locationManager: CLLocationManager { get set }
    
    func checkLocationServices()
    func getCurrentLocation()
    
    func getCity(at point: CLLocationCoordinate2D) -> City?
    func showCityMarkers()
    func showWorkingArea(for city: City)
    func showPolygon(for city: City)
}

//MARK: - MapPresenter

extension Map {
    class Presenter: NSObject, MapPresenter {
        
        var router: MapRouter?
        var interactor: MapInteractor?
        weak var view: MapViewController?
        
        var locationManager = CLLocationManager()
        var didFindLocation = false
        
        func checkLocationServices() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways:
                //Not added to info.plist, but if added in the future
                getCurrentLocation()
            case .authorizedWhenInUse:
                getCurrentLocation()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                router?.showManualCityPicker()
            case .restricted:
                router?.showManualCityPicker()
            }
        }
        
        @objc func getCurrentLocation() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        }
        
        func getCity(at point: CLLocationCoordinate2D) -> City? {
            //TODO: Pending Implementation
            return City()
        }
        
        func showCityMarkers() {
            //TODO: Pending implementation
        }
        
        func showWorkingArea(for city: City) {
            //TODO: Pending implementation
        }
        
        func showPolygon(for city: City) {
            //TODO: Pending implementation
        }
    }
}

//MARK: - CLLocationManagerDelegate

extension Map.Presenter: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecent = locations.last else { return }
        locationManager.stopUpdatingLocation()
        if didFindLocation { return }
        if let currentCity = getCity(at: mostRecent.coordinate) {
            router?.show(currentCity)
        } else {
            router?.showManualCityPicker()
        }
        didFindLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let host = view as? Map.ViewController {
            router?.presentAlert(from: host, with: Localized.Map.Alert.title, and: error.localizedDescription, using: .alert, and: [UIAlertAction(title: Localized.Map.Alert.ok, style: .default, handler: nil)])
        }
    }
}
