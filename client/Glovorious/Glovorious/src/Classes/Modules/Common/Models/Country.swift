//
//  Country.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 23/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation

class Country: NSObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "name"
    }
    var code: String
    var name: String
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
        super.init()
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try values.decode(String.self, forKey: .code)
        name = try values.decode(String.self, forKey: .name)
    }
}
