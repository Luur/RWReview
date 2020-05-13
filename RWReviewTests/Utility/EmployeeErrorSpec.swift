//
//  EmployeeErrorSpec.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RWReview

class EmployeeErrorSpec: QuickSpec {
    
    override func spec() {

        // MARK: - Subject under test
    
        var sut: EmployeeError!
    
        // MARK: - Tests
        
        describe("property errorDescription") {
            
            context("when case is blankEmail") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .blankEmail
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Email address cannot be blank"))
                }
            }
            
            context("when case is invalidEmail") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .invalidEmail
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Invalid email address"))
                }
            }
            
            context("when case is blankFirstName") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .blankFirstName
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("First name cannot be blank"))
                }
            }
            
            context("when case is blankLastName") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .blankLastName
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Last name cannot be blank"))
                }
            }
            
            context("when case is invalidPhone") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .invalidPhone
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Invalid phone number"))
                }
            }
            
            context("when case is startDateNotSelected") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .startDateNotSelected
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Start date should be selected"))
                }
            }
            
            context("when case is birthDateNotSelected") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .birthDateNotSelected
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Birth date should be selected"))
                }
            }
            
            context("when case is roleNotSelected") {
                           
                it("should return errorDescription") {
                    // Given
                    sut = .roleNotSelected
                    // When
                    let result = sut.errorDescription
                    // Then
                    expect(result).to(equal("Role should be selected"))
                }
            }
        }
    }
}
