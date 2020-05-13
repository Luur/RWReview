//
//  ValidatorSpec.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import Quick
import Nimble
import PhoneNumberKit
@testable import RWReview

class ValidatorSpec: QuickSpec {
    
    override func spec() {
    
        // MARK: - Subject under test
    
        var sut: Validator!
    
        // MARK: - Test setup
    
        beforeEach {
            sut = Validator()
        }
    
        // MARK: - Tests
        
        describe("function validate") {
            
            describe("with required validation rule") {
                
                let error = DummyError()
                let rule = RequiredValidationRule(error: error)
                
                context("when empty text provided") {
                    
                    it("should return provided error") {
                        // Given
                        // When
                        let result = sut.validate("", with: [rule])
                        // Then
                        expect(result[0].localizedDescription).to(equal(error.localizedDescription))
                    }
                }
                
                context("when not empty text provided") {
                    
                    it("should not return provided error") {
                        // Given
                        // When
                        let result = sut.validate("text", with: [rule])
                        // Then
                        expect(result).to(beEmpty())
                    }
                }
            }
            
            describe("with email validation rule") {
                
                let error = DummyError()
                let rule = EmailValidationRule(error: error)
                
                context("when invalid email provided") {
                    
                    it("should return provided error") {
                        // Given
                        // When
                        let result = sut.validate("invalid_email", with: [rule])
                        // Then
                        expect(result[0].localizedDescription).to(equal(error.localizedDescription))
                    }
                }
                
                context("when valid email provided") {
                    
                    it("should not return provided error") {
                        // Given
                        // When
                        let result = sut.validate("example_email@gmail.com", with: [rule])
                        // Then
                        expect(result).to(beEmpty())
                    }
                }
            }
            
            describe("with phone number validation rule") {
                
                let phoneNumberKitMock = PhoneNumberKitMock()
                let error = DummyError()
                let rule = PhoneNumberValidationRule(error: error, phoneNumberKit: phoneNumberKitMock)
                
                it("shold ask phoneNumnerKit to call isValidPhoneNumber function") {
                    // Given
                    phoneNumberKitMock.isValidPhoneNumberResult = false
                    // When
                    _ = sut.validate("", with: [rule])
                    // Then
                    expect(phoneNumberKitMock.isValidPhoneNumberCalled).to(beTrue())
                }
                
                it("shold pass input as isValidPhoneNumber function argument") {
                    // Given
                    phoneNumberKitMock.isValidPhoneNumberResult = false
                    let input = "phone_number"
                    // When
                    _ = sut.validate(input, with: [rule])
                    // Then
                    expect(phoneNumberKitMock.isValidPhoneNumberArgument).to(equal(input))
                }
                
                context("when isValidPhoneNumber returns false") {
                    
                    it("should return provided error") {
                        // Given
                        phoneNumberKitMock.isValidPhoneNumberResult = false
                        // When
                        let result = sut.validate("", with: [rule])
                        // Then
                        expect(result[0].localizedDescription).to(equal(error.localizedDescription))
                    }
                }
                
                context("when isValidPhoneNumber returns true") {
                    
                    beforeEach {
                        phoneNumberKitMock.isValidPhoneNumberResult = true
                    }
                    
                    it("shold ask phoneNumnerKit to call parse function") {
                        // Given
                        // When
                        _ = sut.validate("", with: [rule])
                        // Then
                        expect(phoneNumberKitMock.parseCalled).to(beTrue())
                    }
                    
                    it("shold pass input as parse function argument") {
                        // Given
                        let input = "phone_number"
                        // When
                        _ = sut.validate(input, with: [rule])
                        // Then
                        expect(phoneNumberKitMock.parseArgument).to(equal(input))
                    }
                    
                    context("when parse function returns phone number") {
                        
                        it("should not return provided error") {
                            // Given
                            let phoneNumber = PhoneNumberKit().getExampleNumber(forCountry: "CA")
                            phoneNumberKitMock.parseResult = phoneNumber
                            // When
                            let result = sut.validate("", with: [rule])
                            // Then
                            expect(result).to(beEmpty())
                        }
                    }
                    
                    context("when parse function throws error") {
                        
                        it("should return provided error") {
                            // Given
                            phoneNumberKitMock.parseResult = nil
                            // When
                            let result = sut.validate("", with: [rule])
                            // Then
                            expect(result[0].localizedDescription).to(equal(error.localizedDescription))
                        }
                    }
                }
            }
            
            describe("with equality validation rule") {
                
                let error = DummyError()
                let otherText = "text"
                let rule = EqualityValidationRule(error: error, value: otherText)
                
                context("when equal textes provided") {
                        
                    it("should not return provided error") {
                        // Given
                        // When
                        let result = sut.validate("text", with: [rule])
                        // Then
                        expect(result).to(beEmpty())
                    }
                }
                    
                context("when not equal textes provided") {
                        
                    it("should return provided error") {
                        // Given
                        // When
                        let result = sut.validate("text123", with: [rule])
                        // Then
                        expect(result[0].localizedDescription).to(equal(error.localizedDescription))
                    }
                }
            }
        }
    }
}
