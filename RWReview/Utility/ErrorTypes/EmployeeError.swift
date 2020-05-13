//
//  EmployeeError.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation

enum EmployeeError: Error {
    case blankEmail
    case invalidEmail
    case blankFirstName
    case blankLastName
    case invalidPhone
    case startDateNotSelected
    case birthDateNotSelected
    case roleNotSelected
}

extension EmployeeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .blankEmail:
            return "Email address cannot be blank"
        case .invalidEmail:
            return "Invalid email address"
        case .blankFirstName:
            return "First name cannot be blank"
        case .blankLastName:
            return "Last name cannot be blank"
        case .invalidPhone:
            return "Invalid phone number"
        case .startDateNotSelected:
            return "Start date should be selected"
        case .birthDateNotSelected:
            return "Birth date should be selected"
        case .roleNotSelected:
            return "Role should be selected"
        }
    }
}
