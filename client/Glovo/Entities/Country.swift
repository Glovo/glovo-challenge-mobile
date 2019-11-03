//
//  Country.swift
//  Glovo
//
//  Created by Eugène Peschard on 11/03/2019.
//  Copyright © 2019 pesch.app. All rights reserved.
//

import RealmSwift

@objcMembers public class Country: Object {
    dynamic var code: String = ""
    dynamic var name: String = ""
    
    let cities = LinkingObjects(fromType: City.self,
                                property: City.Property.country.rawValue)//.sorted(byKeyPath: "name")
    
    override public static func primaryKey() -> String? {
        return Country.Property.code.rawValue
    }
    
    enum Property: String {
        case code, name
    }
}
