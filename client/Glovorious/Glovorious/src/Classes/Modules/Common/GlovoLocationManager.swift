//
//  GlovoLocationManager.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 28/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation
import CoreLocation


struct GlovoLocationManagerDelegate  {
    weak var item: CLLocationManagerDelegate?
    
    init(item: CLLocationManagerDelegate) {
        self.item = item
    }
}

protocol IGlovoLocationManager: class {
    func register(delegate: CLLocationManagerDelegate)
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}
class GlovoLocationManager: NSObject, IGlovoLocationManager {
    let locationManager: CLLocationManager?
    var delegates: [GlovoLocationManagerDelegate] = []
    
    
    override init() {
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        super.init()
        locationManager?.delegate = self
        locationManager?.distanceFilter = 10.0
        requestWhenInUseAuthorization()
    }
    
    func register(delegate: CLLocationManagerDelegate) {
        delegates.append(GlovoLocationManagerDelegate(item: delegate))
    }
    
    func requestWhenInUseAuthorization() {
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager?.stopUpdatingLocation()
    }
    

    private func updateLocationIfPossible(with status: CLAuthorizationStatus) {
        
        // Start updating location for Shuffle cards.
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        default:
            locationManager?.stopUpdatingLocation()
        }
    }
}

// MARK : CLLocationManagerDelegate
extension GlovoLocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for delegate in delegates {
            delegate.item?.locationManager?(manager, didUpdateLocations: locations)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        for delegate in delegates {
            delegate.item?.locationManager?(manager, didFailWithError: error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        for delegate in delegates {
            delegate.item?.locationManager?(manager, didChangeAuthorization: status)
        }
        
        self.updateLocationIfPossible(with: status)
    }
}
