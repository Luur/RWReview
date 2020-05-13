//
//  WebRepositoryError.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import SwiftyJSON

enum WebRepositoryError: Error, CustomNSError, Equatable {
    case noInternetConnection
    case unknown
    case custom(message: String?)
    case unauthorized
    case forbidden
    case invalidCredentials
}

extension WebRepositoryError: LocalizedError {
   var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "The Internet connection appears to be offline."
        case .unknown:
            return "Something went wrong. Please try again later."
        case .unauthorized:
            return "Session ended. Please sign in again."
        case .forbidden:
            return "Access to that resource is forbidden."
        case .invalidCredentials:
            return "Combination of email and password is invalid"
        case .custom(let message):
            return message
        }
    }
}

extension WebRepositoryError {
    
    /*
     422 Error JSON Example:
     
     {
       "errors" : {
         "email" : [
           "has already been taken"
         ]
       }
     }
     */
    
    init(statusCode: Int, json: JSON) {
        switch statusCode {
        case 400, 404:
            let message = json["errors"].array?.first?["detail"].string
            self = .custom(message: message)
        case 401:
            self = .unauthorized
        case 403:
            self = .forbidden
        case 422:
            let value = json["errors"].dictionary?.values.first
            let key = json["errors"].dictionary?.keys.first
            if let key = key, let message = value?.array?.first?.string {
                self = .custom(message: "\(key.capitalized) \(message)")
            } else {
                self = .unknown
            }
        default:
            self = .unknown
        }
    }
    
    init(errorCode: URLError.Code?) {
        switch errorCode {
        case .notConnectedToInternet?:
            self = .noInternetConnection
        default:
            self = .unknown
        }
    }
}
