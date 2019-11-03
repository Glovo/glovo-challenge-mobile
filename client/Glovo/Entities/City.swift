//
//  City.swift
//  Glovo
//
//  Created by Eugène Peschard on 11/03/2019.
//  Copyright © 2019 pesch.app. All rights reserved.
//

import RealmSwift
import GoogleMaps

@objcMembers class City: Object {
    dynamic var code: String = ""
    dynamic var name: String = ""
    dynamic var currency: String?
    dynamic var country_code: String = ""
    dynamic var country: Country?
    var enabled = RealmOptional<Bool>()
    dynamic var time_zone: String?
    var busy = RealmOptional<Bool>()
    dynamic var language_code: String?
    // Realm list storing the array of polylines
    var working_area = List<String>()
    
    override public static func primaryKey() -> String? {
        return City.Property.code.rawValue
    }
    
    enum Property: String {
        case code, name, currency, country_code, country, enabled, time_zone, busy, language_code, working_area, northEastLat, northEastLon, southWestLat, southWestLon
    }
}
