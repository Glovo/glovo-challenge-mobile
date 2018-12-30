//
//  GlovoAnnotation.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 29/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation
import MapKit

class GlovoAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var name: String
    var countryCode: String
    var timeZone: String
    var cityCode: String
    var currency: String
    init(coordinate: CLLocationCoordinate2D, city: City) {
        self.coordinate = coordinate
        self.name = city.name
        self.countryCode = city.countryCode
        self.timeZone = city.timeZone
        self.cityCode = city.code
        self.currency = city.currency
        super.init()
    }
}
