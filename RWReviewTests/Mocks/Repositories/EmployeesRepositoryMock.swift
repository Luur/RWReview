//
//  EmployeesRepositoryMock.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
@testable import RWReview

class EmployeesRepositoryMock: EmployeesRepositoryProtocol {
    
    // MARK: - Method results
    
    var fetchEmployeesResult: (employees: [Employee], error: Error?)!
    var fetchEmployeeDetailsResult: (employeeDetails: Employee.Details?, error: Error?)
    var createEmployeeResult: (employee: Employee?, error: Error?)
    
    // MARK: - Argument expectations
    
    var fetchEmployeeDetailsArgument: Int!
    
    // MARK: - Method call expectations
    
    var fetchEmployeesCalled = false
    var fetchEmployeeDetailsCalled = false
    var createEmployeeCalled = false
    
    // MARK: - Mocked methods
    
    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> Void) {
        fetchEmployeesCalled = true
        if !fetchEmployeesResult.employees.isEmpty {
            completion(.success(fetchEmployeesResult.employees))
        } else if let error = fetchEmployeesResult.error {
            completion(.failure(error))
        }
    }
    
    func fetchEmployeeDetails(with id: Int, completion: @escaping (Result<Employee.Details, Error>) -> Void) {
        fetchEmployeeDetailsCalled = true
        fetchEmployeeDetailsArgument = id
        if let details = fetchEmployeeDetailsResult.employeeDetails {
            completion(.success(details))
        } else if let error = fetchEmployeeDetailsResult.error {
            completion(.failure(error))
        }
    }
    
    func createEmployee(_ encodableEmployee: EmployeeEncodableModel, completion: @escaping (Result<Employee, Error>) -> Void) {
        createEmployeeCalled = true
        if let employee = createEmployeeResult.employee {
            completion(.success(employee))
        } else if let error = createEmployeeResult.error {
            completion(.failure(error))
        }
    }
}
