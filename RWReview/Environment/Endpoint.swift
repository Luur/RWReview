//
//  Endpoint.swift
//  RWReview
//
//  Created by Svyat Zubyak on 12.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation

protocol EndpointDeclarationProtocol {
    static var method : Endpoint.RequestMethod { get }
    static var path : String { get }
}

struct Endpoint {
    
    enum RequestMethod: String {
        case options = "OPTIONS"
        case get = "GET"
        case head = "HEAD"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        case trace = "TRACE"
        case connect = "CONNECT"
    }
    
    enum Placeholders : String {
        case userID = "{{USER_ID}}"
        case startDate = "{{START_DATE}}"
        case endDate = "{{END_DATE}}"
        case frequency = "{{FREQUENCY}}"
        case employeeID = "{{EMPLOYEE_ID}}"
        case clinicID = "{{CLINIC_ID}}"
    }
    
    static func fullPath(_ path: String, baseURL: String?, placeholders: [Placeholders: String]? = nil) -> String {
        guard path.lowercased().range(of: "http") == nil else { return path }
        let url  = replacePlaceholdersWithActuals(baseURL ?? "", placeholders: placeholders)
        let path = replacePlaceholdersWithActuals(path, placeholders: placeholders)
        let codedPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? path
        return "\(url)\(codedPath)"
    }
    
    private static func replacePlaceholdersWithActuals(_ path: String, placeholders: [Placeholders: String]?) -> String {
        guard let phs = placeholders, phs.count > 0 else { return path }
        var updatedPath = path
        for (ph, value) in phs {
            updatedPath = updatedPath.replacingOccurrences(of: ph.rawValue, with: value)
        }
        return updatedPath
    }
}
