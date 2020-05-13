//
//  ValidatorMock.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
@testable import RWReview

class ValidatorMock: Validator {
    
    // MARK: - Method results
    
    var validateResult: [Error]!
    
    // MARK: - Method call expectations
    
    var validateCalled = false
    
    // MARK: - Method invocations expectations
    
    struct ValidateInvocations {
        var count: Int
        var arguments: [(input: String, rules: [ValidationRule])]
    }
    
    var validateInvocations = ValidateInvocations(count: 0, arguments: [])
    
    // MARK: - Argument expectations
    
    var validateArguments: (input: String, rules: [ValidationRule])!
    
    // MARK: - Mocked methods
    
    override func validate(_ input: String, with rules: [ValidationRule]) -> [Error] {
        validateCalled = true
        validateInvocations.count += 1
        let arguments = (input: input, rules: rules)
        validateInvocations.arguments.append(arguments)
        validateArguments = arguments
        return validateResult
    }
}

