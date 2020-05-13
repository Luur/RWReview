//
//  EmployeesRepositoryProviderMock.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
@testable import RWReview

class EmployeesRepositoryProviderMock: EmployeesRepositoryProviderProtocol {
    
    // MARK: - Method results
    
    var getEmployeesRepositoryResult: EmployeesRepositoryMock!
    
    // MARK: - Method call expectations
    
    var getEmployeesRepositoryCalled = false
    
    // MARK: - Mocked methods
    
    func getEmployeesRepository() -> EmployeesRepositoryProtocol {
        getEmployeesRepositoryCalled = true
        return getEmployeesRepositoryResult
    }
}

