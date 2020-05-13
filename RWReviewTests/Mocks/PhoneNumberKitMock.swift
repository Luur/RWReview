//
//  PhoneNumberKitMock.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import PhoneNumberKit
@testable import RWReview

class PhoneNumberKitMock: PhoneNumberKitProtocol {
    
    // MARK: - Method results
    
    var countryCodeResult: UInt64?
    var formatResult: String!
    var parseResult: PhoneNumber?
    var isValidPhoneNumberResult: Bool!
    
    // MARK: - Method call expectations

    var countryCodeCalled = false
    var formatCalled = false
    var parseCalled = false
    var isValidPhoneNumberCalled = false
    
    // MARK: - Argument expectations
    
    var countryCodeArgument: String!
    var formatArguments: (phoneNumber: PhoneNumber, formatType: PhoneNumberFormat)!
    var parseArgument: String!
    var isValidPhoneNumberArgument: String!

    // MARK: - Mocked methods
    
    func countryCode(for country: String) -> UInt64? {
        countryCodeArgument = country
        countryCodeCalled = true
        return countryCodeResult
    }
    
    func format(_ phoneNumber: PhoneNumber, toType formatType: PhoneNumberFormat, withPrefix prefix: Bool = true) -> String {
        formatCalled = true
        formatArguments = (phoneNumber: phoneNumber, formatType: formatType)
        return formatResult
    }
    
    func parse(_ numberString: String, withRegion region: String = PhoneNumberKit.defaultRegionCode(), ignoreType: Bool = false) throws -> PhoneNumber {
        parseCalled = true
        parseArgument = numberString
        if let phoneNumber = parseResult {
            return phoneNumber
        } else {
            throw DummyError()
        }
    }
    
    func isValidPhoneNumber(_ numberString: String, withRegion region: String = PhoneNumberKit.defaultRegionCode(), ignoreType: Bool = false) -> Bool {
        isValidPhoneNumberCalled = true
        isValidPhoneNumberArgument = numberString
        return isValidPhoneNumberResult
    }
}
