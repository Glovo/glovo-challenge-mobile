//
//  GlovoDataManager.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 23/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation
import CoreLocation

protocol IGlovoDataManager {
    func loadLastLocation() -> CLLocationCoordinate2D?
    func saveCurrentLocation(_ location: CLLocationCoordinate2D)
}

class GlovoDataManager:NSObject, IGlovoDataManager {

    static let sharedInstance: IGlovoDataManager = {_ -> IGlovoDataManager in
        return GlovoDataManager(userDefaults: UserDefaults.standard)
    }(())
    
    let keyCurrentLocation = "CURRENT_LOCATION"
    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func saveCurrentLocation(_ location: CLLocationCoordinate2D) {
        userDefaults.set("\(location.latitude),\(location.longitude)", forKey: keyCurrentLocation)
    }
    
    func loadLastLocation() -> CLLocationCoordinate2D? {
        let locationString = userDefaults.string(forKey: keyCurrentLocation)
        if let components = locationString?.components(separatedBy: ","), components.count == 2 {
            if let latitude = Double(components[0]), let longitude = Double(components[1]) {
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
        return CLLocationCoordinate2D.init(latitude: 30.07442, longitude: 31.22297)
    }
}
