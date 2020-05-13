//
//  Seeds.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
@testable import RWReview

struct Seeds {
    static let employee = Employee(id: 0, firstName: "Diana", lastName: "Boo", profilePictureURL: "", isActive: false, role: employeeRole)
    static let encodableEmployee = EmployeeEncodableModel(firstName: "John", lastName: "Doe", startDate: nil, birthDate: nil, email: "john.doe@gmail.com", phone: 5192225555, image: nil)
    static let employeeRole = Employee.Role(id: 0, name: "Doctor")
    static let employeeDetails = Employee.Details(email: "john.doe@gmail.com", phone: "0937500618", startDate: TimeInterval(1579515648.0), birthDate: TimeInterval(1552514348.0))
}

struct DummyError: Error {}

extension DummyError: LocalizedError {
    var errorDescription: String? {
        NSLocalizedString("dummy_error", comment: "")
    }
}
