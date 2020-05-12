//
//  EmployeesRepositoryProvider.swift
//  RWReview
//
//  Created by Svyat Zubyak on 12.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation

protocol EmployeesRepositoryProtocol {
    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> Void)
    func fetchEmployeeDetails(with id: Int, completion: @escaping (Result<Employee.Details, Error>) -> Void)
    func createEmployee(_ encodableEmployee: EmployeeEncodableModel, completion: @escaping (Result<Employee, Error>) -> Void)
}

protocol EmployeesRepositoryProviderProtocol {
    func getEmployeesRepository() -> EmployeesRepositoryProtocol
}

class EmployeesRepositoryProvider: EmployeesRepositoryProviderProtocol {
    
    func getEmployeesRepository() -> EmployeesRepositoryProtocol {
        switch Environment.currentEnvironment.type {
        case .Mock:
            return EmployeesMemoryRepository()
        case .REST:
            return EmployeesWebRepository()
        }
    }
}
