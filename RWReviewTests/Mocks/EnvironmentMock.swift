//
//  EnvironmentMock.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
@testable import RWReview

class EnvirontmentMock: Environment {
    
    // MARK: - Method results
    
    var authorizedRequestResult: (success: (json: Any, statusCode: Int)?, error: Error?)
    var unauthorizedRequestResult: (success: (json: Any, statusCode: Int)?, error: Error?)
             
    // MARK: - Method call expectations
             
    var authorizedRequestCalled = false
    var unauthorizedRequestCalled = false
             
    // MARK: - Argument expectations
             
    var authorizedRequestArguments: (requestMethod: Endpoint.RequestMethod, path: String, params: [String : Any]?, urlParams: [Endpoint.Placeholders : String]?)!
    var unauthorizedRequestArguments: (requestMethod: Endpoint.RequestMethod, path: String, params: [String : Any]?, headers: [String : String], urlParams: [Endpoint.Placeholders : String]?)!
             
    // MARK: - Mocked methods
    
    override func authorizedRequest(requestMethod: Endpoint.RequestMethod, path: String, params: [String : Any]?, urlParams: [Endpoint.Placeholders : String]?, success: @escaping (Any, Int) -> Void, failure: @escaping (Error) -> Void) {
        authorizedRequestCalled = true
        authorizedRequestArguments = (requestMethod: requestMethod, path: path, urlParams: urlParams, params: params)
        if let successResult = authorizedRequestResult.success {
            success(successResult.json, successResult.statusCode)
        } else if let error = authorizedRequestResult.error{
            failure(error)
        }
    }
    
    override func unauthorizedRequest(requestMethod: Endpoint.RequestMethod, path: String, params: [String : Any]? = nil, headers: [String : String] = [:], urlParams: [Endpoint.Placeholders : String]? = nil, success: @escaping (Any, Int) -> Void, failure: @escaping (Error) -> Void) {
        unauthorizedRequestCalled = true
        unauthorizedRequestArguments = (requestMethod: requestMethod, path: path, params: params, headers: headers, urlParams: urlParams)
        if let successResult = unauthorizedRequestResult.success {
            success(successResult.json, successResult.statusCode)
        } else if let error = unauthorizedRequestResult.error{
            failure(error)
        }
    }
}
