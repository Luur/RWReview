//
//  EmployeesMemoryRepository.swift
//  RWReview
//
//  Created by Svyat Zubyak on 12.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation

class EmployeesMemoryRepository: EmployeesRepositoryProtocol {
    
    // MARK: - Data
    
    static let employee = Employee(id: 0, firstName: "Ben", lastName: "Doe", profilePictureURL: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_running_other/1800x1200_dog_running_other.jpg", isActive: true, role: role)
    
    static let employees = [
        Employee(id: 0, firstName: "John", lastName: "Doe", profilePictureURL: "", isActive: true, role: role),
        Employee(id: 1, firstName: "Leo", lastName: "Knight", profilePictureURL: "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/dog_running_other/1800x1200_dog_running_other.jpg", isActive: false, role: role),
        Employee(id: 2, firstName: "Diana", lastName: "Boo", profilePictureURL: "", isActive: false, role: role)
    ]
    
    static let details = Employee.Details(email: "john.doe@gmail.com", phone: "5192222222", startDate: TimeInterval(1579515648.0), birthDate: TimeInterval(1552514348.0))
    
    static let role = Employee.Role(id: 0, name: "Doctor")
    
    // MARK: - Methods
    
    func fetchEmployees(completion: @escaping (Result<[Employee], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            completion(.success(type(of: self).employees))
        })
    }
    
    func fetchEmployeeDetails(with id: Int, completion: @escaping (Result<Employee.Details, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            completion(.success(type(of: self).details))
        })
    }
    
    func createEmployee(_ encodableEmployee: EmployeeEncodableModel, completion: @escaping (Result<Employee, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            completion(.success(type(of: self).employee))
        })
    }
}
