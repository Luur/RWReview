//
//  Environment.swift
//  RWReview
//
//  Created by Svyat Zubyak on 12.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import Alamofire

class Environment {
    
    var type: EnvironmentType = .Mock
    var name: String?
    var baseURL: String?
    
    enum EnvironmentType: String {
        case Mock
        case REST
    }
    
    static private var cachedCurrentEnvironment: Environment?
    
    private static var environments = [
        Environment(name: "Mock", type: .Mock),
        Environment(name: "Production", type: .REST, baseURL: "production_base_url"),
        Environment(name: "Development", type: .REST, baseURL: "development_base_url")
    ]
    
    init(name: String, type: EnvironmentType, baseURL: String? = nil) {
        self.name = name
        self.type = type
        self.baseURL = baseURL
    }
    
    static var currentEnvironment: Environment {
        if let cachedEnvironment = cachedCurrentEnvironment {
            return cachedEnvironment
        }
        let cachedEnvironment = getSavedEnvironment()
        cachedCurrentEnvironment = cachedEnvironment
        return cachedEnvironment
    }
    
    private static func getSavedEnvironment() -> Environment {
        guard let environmentName = UserDefaultsConfig.environment else {
            fatalError("No saved environment")
        }
        return getEnvironment(name: environmentName)
    }
    
    static func saveEnvironment(name: String) {
        cachedCurrentEnvironment = getEnvironment(name: name)
        UserDefaultsConfig.environment = name
    }
    
    private static func getEnvironment(name: String) -> Environment {
        guard let environment = environments.filter({$0.name == name}).first else {
            fatalError("No environment with name \(name)")
        }
        return environment
    }
    
    func unauthorizedRequest(requestMethod: Endpoint.RequestMethod, path: String, params: [String: Any]? = nil, headers: [String: String] = [:], urlParams: [Endpoint.Placeholders: String]? = nil, success: @escaping (Any, Int) -> Void, failure: @escaping (Error) -> Void) {
        
        request(requestMethod: requestMethod, path: path, params: params, headers: headers, urlParams: urlParams, success: success, failure: failure)
    }
    
    func authorizedRequest(requestMethod: Endpoint.RequestMethod, path: String, params: [String: Any]? = nil, urlParams: [Endpoint.Placeholders: String]? = nil, success: @escaping (Any, Int) -> Void, failure: @escaping (Error) -> Void) {
        
        request(requestMethod: requestMethod, path: path, params: params, headers: headers(), urlParams: urlParams, success: success, failure: failure)
    }
}

extension Environment {
    
    private func request(requestMethod: Endpoint.RequestMethod, path: String, params: [String: Any]?, headers: [String: String], urlParams: [Endpoint.Placeholders: String]?, success: @escaping (Any, Int) -> Void, failure: @escaping (Error) -> Void) {
        
        let fullPath = Endpoint.fullPath(path, baseURL: baseURL, placeholders: urlParams)
        let method = HTTPMethod(rawValue: requestMethod.rawValue)
        let headers = HTTPHeaders(headers)
        
        AF.request(fullPath, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let statusCode = response.response?.statusCode ?? 0
            switch response.result {
            case .success(let json):
                if let activeToken = response.response?.allHeaderFields["ACTIVE_TOKEN"] as? String {
                    self.token = activeToken
                }
                success(json, statusCode)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

extension Environment {
    
    private var token : String? {
        get {
            UserDefaultsConfig.token
        }
        set {
            UserDefaultsConfig.token = newValue
        }
    }
    
    private func headers() -> [String: String] {
        if let token = token {
            return ["Authorization" : "Bearer \(token)"]
        } else {
            return [:]
        }
    }
}
