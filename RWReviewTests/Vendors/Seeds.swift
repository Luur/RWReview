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
    
    static let encodableEmployee = EmployeeEncodableModel(firstName: "John", lastName: "Doe", startDate: nil, birthDate: nil, email: "john.doe@gmail.com", phone: 5192225555, image: nil)
}

struct DummyError: Error {}

extension DummyError: LocalizedError {
    var errorDescription: String? {
        NSLocalizedString("dummy_error", comment: "")
    }
}
