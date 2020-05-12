//
//  EmployeesWebRepository.swift
//  RWReview
//
//  Created by Svyat Zubyak on 12.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation

import SwiftyJSON

class EmployeesWebRepository: EmployeesRepositoryProtocol {
    
    private var environment: Environment
    
    init(environment: Environment = .currentEnvironment) {
        self.environment = environment
    }
    
    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> Void) {
        environment.authorizedRequest(requestMethod: EmployeesEndpoint.FetchEmployees.method, path: EmployeesEndpoint.FetchEmployees.path, success: { (result, statusCode) in
            let json = JSON(result)
            switch statusCode {
            case 200...299:
                let employees = json.arrayValue.map { Employee(json: $0) }
                completion(.success(employees))
            default:
                let error = WebRepositoryError(statusCode: statusCode, json: json)
                completion(.failure(error))
            }
        }) { error in
            let error = WebRepositoryError(errorCode: error.urlErrorCode)
            completion(.failure(error))
        }
    }
    
    func fetchEmployeeDetails(with id: Int, completion: @escaping (Result<Employee.Details, Error>) -> Void) {
        
        let urlParams = [Endpoint.Placeholders.employeeID: String(id)]
        
        environment.authorizedRequest(requestMethod: EmployeesEndpoint.FetchEmployeeDetails.method, path: EmployeesEndpoint.FetchEmployeeDetails.path, urlParams: urlParams, success: { (result, statusCode) in
            let json = JSON(result)
            switch statusCode {
            case 200...299:
                let details = Employee.Details(json: json)
                completion(.success(details))
            default:
                let error = WebRepositoryError(statusCode: statusCode, json: json)
                completion(.failure(error))
            }
        }) { error in
            let error = WebRepositoryError(errorCode: error.urlErrorCode)
            completion(.failure(error))
        }
    }
    
    func createEmployee(_ encodableEmployee: EmployeeEncodableModel, completion: @escaping (Result<Employee, Error>) -> Void) {
        
        let params = encodableEmployee.encoded
        
        environment.authorizedRequest(requestMethod: EmployeesEndpoint.CreateEmployee.method, path: EmployeesEndpoint.CreateEmployee.path, params: params, success: { (result, statusCode) in
            let json = JSON(result)
            switch statusCode {
            case 200...299:
                let employee = Employee(json: json)
                completion(.success(employee))
            default:
                let error = WebRepositoryError(statusCode: statusCode, json: json)
                completion(.failure(error))
            }
        }) { error in
            let error = WebRepositoryError(errorCode: error.urlErrorCode)
            completion(.failure(error))
        }
    }
}
