//
//  GlovoAPIs.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 23/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation

public enum RequestMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum Encoding: String {
    case url    = "URL"
    case json   = "JSON"
    case plist  = "PLIST"
}

extension GlovoService {
    enum API {
        static func country() -> String {
            return "countries/"
        }
        static func city() -> String {
            return "cities/"
        }
    }
}
