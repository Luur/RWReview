//
//  WebRepositoryErrorSpec.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftyJSON
@testable import RWReview

class WebRepositoryErrorSpec: QuickSpec {
    
    override func spec() {

        // MARK: - Subject under test
    
        var sut: WebRepositoryError!
    
        // MARK: - Tests
        
        describe("initialization") {
            
            context("when init with statusCode") {
                
                context("when status code is 400 or 404") {
                    
                    it("should be initalized as custom with message") {
                        // Given
                        let message = "error_message"
                        let json = JSON(HTTPErrors.BadRequest(message: message).encoded)
                        // When
                        sut = WebRepositoryError(statusCode: 400, json: json)
                        // Then
                        expect(sut).to(equal(.custom(message: message)))
                    }
                }
                
                context("when status code is 422") {
                    
                    context("when json is valid") {
                        
                        it("should be initalized as custom with message") {
                            // Given
                            let message = "error_message"
                            let mirror = Mirror(reflecting: HTTPErrors.UnprocessableEntity(message: message).errors)
                            let json = JSON(HTTPErrors.UnprocessableEntity(message: message).encoded)
                            // When
                            sut = WebRepositoryError(statusCode: 422, json: json)
                            // Then
                            if let errorKey = mirror.children.first?.label {
                                expect(sut).to(equal(.custom(message: "\(errorKey.capitalized) \(message)")))
                            } else {
                                fail()
                            }
                        }
                    }
                    
                    context("when json is invalid") {
                        
                        it("should be initalized as unknown") {
                            // Given
                            let json = JSON(HTTPErrors.UnprocessableEntity(message: nil).encoded)
                            // When
                            sut = WebRepositoryError(statusCode: 422, json: json)
                            // Then
                            expect(sut).to(equal(.unknown))
                        }
                    }
                }
                
                context("when status code is 401") {
                    
                    it("should be initalized as unauthorized") {
                        // Given
                        // When
                        sut = WebRepositoryError(statusCode: 401, json: JSON())
                        // Then
                        expect(sut).to(equal(.unauthorized))
                    }
                }
                
                context("when status code is 403") {
                    
                    it("should be initalized as forbidden") {
                        // Given
                        // When
                        sut = WebRepositoryError(statusCode: 403, json: JSON())
                        // Then
                        expect(sut).to(equal(.forbidden))
                    }
                }
                
                context("when status code is not exhaustive") {
                    
                    it("should be initalized as unknown") {
                        // Given
                        // When
                        sut = WebRepositoryError(statusCode: 405, json: JSON())
                        // Then
                        expect(sut).to(equal(.unknown))
                    }
                }
            }
            
            context("when init with errorCode") {
                
                context("when error code is not exhaustive") {
                    
                    it("should be initalized as unknown") {
                        // Given
                        // When
                        sut = WebRepositoryError(errorCode: .badServerResponse)
                        // Then
                        expect(sut).to(equal(.unknown))
                    }
                }
                
                context("when error code is notConnectedToInternet") {
                    
                    it("should be initalized as noInternetConnection") {
                        // Given
                        // When
                        sut = WebRepositoryError(errorCode: .notConnectedToInternet)
                        // Then
                        expect(sut).to(equal(.noInternetConnection))
                    }
                }
            }
        }
        
        describe("property errorDescription") {
            
            context("when case is noInternetConnection") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .noInternetConnection
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("The Internet connection appears to be offline."))
                }
            }
            
            context("when case is unknown") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .unknown
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Something went wrong. Please try again later."))
                }
            }
            
            context("when case is unauthorized") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .unauthorized
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Session ended. Please sign in again."))
                }
            }
            
            context("when case is forbidden") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .forbidden
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Access to that resource is forbidden."))
                }
            }
            
            context("when case is invalidCredentials") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .invalidCredentials
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Combination of email and password is invalid"))
                }
            }
            
            context("when case is custom") {
                           
                it("should return errorDescription") {
                    // Given
                    let message = "custom_message"
                    sut = .custom(message: message)
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal(message))
                }
            }
        }
    }
}
