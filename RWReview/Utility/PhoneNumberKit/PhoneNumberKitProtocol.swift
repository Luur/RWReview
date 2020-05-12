//
//  PhoneNumberKitProtocol.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import PhoneNumberKit

protocol PhoneNumberKitProtocol {
    func isValidPhoneNumber(_ numberString: String, withRegion region: String, ignoreType: Bool) -> Bool
    func countryCode(for country: String) -> UInt64?
    func parse(_ numberString: String, withRegion region: String, ignoreType: Bool) throws -> PhoneNumber
    func format(_ phoneNumber: PhoneNumber, toType formatType: PhoneNumberFormat, withPrefix prefix: Bool) -> String
}

extension PhoneNumberKitProtocol {
    
    func isValidPhoneNumber(_ numberString: String, withRegion region: String = PhoneNumberKit.defaultRegionCode(), ignoreType: Bool = false) -> Bool {
        isValidPhoneNumber(numberString, withRegion: region, ignoreType: ignoreType)
    }
    
    func parse(_ numberString: String, withRegion region: String = PhoneNumberKit.defaultRegionCode(), ignoreType: Bool = false) throws -> PhoneNumber {
        try parse(numberString, withRegion: region, ignoreType: ignoreType)
    }
    
    func format(_ phoneNumber: PhoneNumber, toType formatType: PhoneNumberFormat, withPrefix prefix: Bool = true) -> String {
        format(phoneNumber, toType: formatType, withPrefix: prefix)
    }
}

extension PhoneNumberKit: PhoneNumberKitProtocol {}
