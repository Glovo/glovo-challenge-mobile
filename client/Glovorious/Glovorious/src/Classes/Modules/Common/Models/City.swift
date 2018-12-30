//
//  City.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 24/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation

class City: NSObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case workingArea = "working_area"
        case code = "code"
        case name = "name"
        case countryCode = "country_code"
        case desc = "description"
        case enabled = "enabled"
        case currency = "currency"
        case timeZone = "time_zone"
        case busy = "busy"
        case languageCode = "language_code"
    }
    
    var workingArea: [String] = [String]()
    var code: String
    var name: String
    var countryCode: String
    var desc: String
    var enabled: Bool
    var currency: String
    var timeZone: String
    var busy: Bool
    var languageCode: String
    
    init(workingArea:[String], code: String, name: String, countryCode: String, desc: String, enabled: Bool, currency: String,timezone: String, busy: Bool, languageCode: String) {
        
        self.workingArea = workingArea
        self.code = code
        self.name = name
        self.countryCode = countryCode
        self.desc = desc
        self.enabled = enabled
        self.currency = currency
        self.timeZone = timezone
        self.busy = busy
        self.languageCode = languageCode
        super.init()
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        workingArea = try values.decode([String].self, forKey: .workingArea)
        code = try values.decode(String.self, forKey: .code)
        name = try values.decode(String.self, forKey: .name)
        countryCode = try values.decode(String.self, forKey: .countryCode)
        desc = try values.decodeIfPresent(String.self, forKey: .desc) ?? ""
        currency = try values.decodeIfPresent(String.self, forKey: .currency) ?? ""
        timeZone = try values.decodeIfPresent(String.self, forKey: .timeZone) ?? ""
        languageCode = try values.decodeIfPresent(String.self, forKey: .languageCode) ?? ""
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled) ?? false
        busy = try values.decodeIfPresent(Bool.self, forKey: .busy) ?? false
    }
    
}
