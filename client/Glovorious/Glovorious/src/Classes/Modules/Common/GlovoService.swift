//
//  GlovoService.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 23/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation

protocol IGlovoService {
    func getAllCountry(success: @escaping([Country]) -> Void, failure: @escaping (NSError) -> Void)
    func getAllCity(success: @escaping([City]) -> Void, failure: @escaping(NSError) -> Void)
    func getCity(cityCode: String, success: @escaping(City) -> Void, failure: @escaping(NSError) -> Void)
}

class GlovoService: IGlovoService {
    
    let home = "http://172.20.10.11:3000/api/"
//    let home = "http://localhost:3000/api/"
    
    static let sharedInstance: IGlovoService = { _ -> IGlovoService in
        return GlovoService()
    }(())
    
    var jsonDecoder: JSONDecoder = { _ -> JSONDecoder in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }(())

    init() {
    }
    
    func getAllCountry(success: @escaping ([Country]) -> Void, failure: @escaping (NSError) -> Void) {
        guard let url = URL.init(string: home + API.country()) else {
            return
        }
        executeRequest(RequestMethod.get, url: url, parameters: nil, headers: nil, success: { (response: [Country]) in
            success(response)
        }, failure: {isCache, error in
            failure(error)
        })
    }
    
    func getAllCity(success: @escaping ([City]) -> Void, failure: @escaping (NSError) -> Void) {
        guard let url = URL.init(string: home + API.city()) else {
            return
        }
        executeRequest(RequestMethod.get, url: url, parameters: nil, headers: nil, success: { (response: [City]) in
            success(response)
        }, failure: {isCache, error in
            failure(error)
        })
    }
    
    func getCity(cityCode: String, success: @escaping (City) -> Void, failure: @escaping (NSError) -> Void) {
        guard let url = URL.init(string: home + API.city()) else {
            return
        }
        executeRequest(RequestMethod.get, url: url, parameters: ["cityCode":cityCode], headers: nil, success: { (response:City) in
            success(response)
        }, failure: {isCache, error in
            failure(error)
        })
    }
    fileprivate func executeRequest<T: Decodable>(_ method: RequestMethod, url: URL, parameters: [String: Any]?, headers: [String: String]?, success: @escaping (T) -> Void, failure: @escaping (Bool, NSError) -> Void) {
        glovoSession.startRequest(with: url, method: method, parameters: parameters, headers: headers) { (isCache, data, error) in
            guard let response = data, let result = try? self.jsonDecoder.decode(T.self, from: response) else {
                failure(isCache, NSError(domain: "GlovoService", code: -1, userInfo: nil))
                return
            }
            success(result)
        }
    }
}
