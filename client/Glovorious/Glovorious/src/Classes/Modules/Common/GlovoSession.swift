//
//  GlovoSession.swift
//  Glovorious
//
//  Created by Octo Siswardhono on 23/12/18.
//  Copyright © 2018 Octo Siswardhono. All rights reserved.
//

import Foundation

public class GlovoSessionManager {
    
    let session : URLSession
    let urlCache = URLCache.shared
    
    init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
        sessionConfig.urlCache = urlCache
        session = URLSession(configuration: sessionConfig)
    }
    
    func startRequest(with url: URL, method: RequestMethod, parameters: [String:Any]?, headers: [String:String]?, completed: @escaping (Bool, Data?, Error?) -> Void) -> Void {
        var urlRequest = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60.0)
        urlRequest.httpMethod = method.rawValue
        if let header = headers {
            for (key, value) in header {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if method.rawValue == "GET" {
            guard let url = urlRequest.url else {
                completed(false, nil, self.errorSessionTask())
                return
            }
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), let param = parameters, !param.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(param)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
                let urlPath = urlComponents.url?.absoluteString.replacingOccurrences(of: "?", with: "")
                urlRequest.url = URL(string: urlPath ?? "")
            }
        } else {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = query(parameters ?? [String:String]()).data(using: .utf8, allowLossyConversion: false)
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completed(false, data, error)
            } else if let response = response as? HTTPURLResponse, response.statusCode >= 400 {
                completed(false, data, self.errorSessionTask())
            } else {
                completed(false, data, nil)
            }
        }
        
        task.resume()
    }
    
    private func errorSessionTask() -> NSError {
        let userInfo: [String : Any] = [
            NSLocalizedDescriptionKey :  "Error request",
            NSLocalizedFailureReasonErrorKey : "Error requesting from Server"
        ]
        
        let error = NSError(domain: "com.glovorious.error.glovosession", code: 520, userInfo: userInfo)
        return error
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        
        //NOTE:
        // because the server example by default is not using RFC3986
        // so we don't need to show the 'key' param and preceeded with '?'
        // ref : https://tools.ietf.org/html/rfc3986#section-3
        
        return components.map { "\($1)" }.joined(separator: "")
    }
    
    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        components.append((key, "\(value)"))
        return components
    }
    
    private func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        var escaped = ""
        
        if #available(iOS 8.3, *) {
            escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
        } else {
            let batchSize = 50
            var index = string.startIndex
            
            while index != string.endIndex {
                let startIndex = index
                let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
                let range = startIndex..<endIndex
                
                let substring = string[range]
                
                escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)
                
                index = endIndex
            }
        }
        
        return escaped
    }
}

public let glovoSession = GlovoSessionManager()
