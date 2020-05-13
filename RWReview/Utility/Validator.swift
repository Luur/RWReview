//
//  Validator.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import PhoneNumberKit

class Validator {
    
    enum ValidationResult {
        case success
        case failure
    }
    
    func validate(_ input: String, with rules: [ValidationRule]) -> [Error] {
        rules.compactMap { $0.validate(input) }
    }
}

protocol ValidationRule {
    var error: Error { get }
    func validate(_ input: String) -> Error?
}

class EmailValidationRule: RegexValidationRule {
    
    init(error: Error) {
        super.init(error: error, regex: #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#)
    }
}

class PhoneNumberValidationRule: ValidationRule {
    var error: Error
    var phoneNumberKit: PhoneNumberKitProtocol
    
    init(error: Error, phoneNumberKit: PhoneNumberKitProtocol = PhoneNumberKit()) {
        self.error = error
        self.phoneNumberKit = phoneNumberKit
    }
    
    func validate(_ input: String) -> Error? {
        guard phoneNumberKit.isValidPhoneNumber(input) else { return error }
        let phoneNumber = try? phoneNumberKit.parse(input)
        return phoneNumber == nil ? error : nil
    }
}

class RequiredValidationRule: ValidationRule {
    var error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    func validate(_ input: String) -> Error? {
        input.isEmpty ? error : nil
    }
}

class RegexValidationRule: ValidationRule {
    var error: Error
    var regex: String
    
    init(error: Error, regex: String) {
        self.error = error
        self.regex = regex
    }
    
    func validate(_ input: String) -> Error? {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input) ? nil : error
    }
}

class EqualityValidationRule: ValidationRule {
    var error: Error
    var value: String
    
    init(error: Error, value: String) {
        self.error = error
        self.value = value
    }
    
    func validate(_ input: String) -> Error? {
        input == value ? nil : error
    }
}
