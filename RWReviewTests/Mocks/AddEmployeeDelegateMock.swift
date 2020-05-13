//
//  AddEmployeeDelegateMock.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
@testable import RWReview

class AddEmployeeDelegateMock: AddEmployeeDelegate {
    
    // MARK: - Method call expectations

    var employeeCreatedCalled = false
    
    // MARK: - Argument expectations
    
    var employeeCreatedArgument: EmployeeViewModel!

    // MARK: - Mocked methods
    
    func employeeCreated(_ employee: EmployeeViewModel) {
        employeeCreatedArgument = employee
        employeeCreatedCalled = true
    }
}
