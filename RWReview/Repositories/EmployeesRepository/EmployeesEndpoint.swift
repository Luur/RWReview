//
//  EmployeesEndpoint.swift
//  RWReview
//
//  Created by Svyat Zubyak on 12.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation

struct EmployeesEndpoint {
    
    struct FetchEmployees: EndpointDeclarationProtocol {
        static let method: Endpoint.RequestMethod = .get
        static let path = "employees"
    }
    
    struct FetchEmployeeDetails: EndpointDeclarationProtocol {
        static let method: Endpoint.RequestMethod = .get
        static let path = "employees/{{EMPLOYEE_ID}}"
    }
    
    struct CreateEmployee: EndpointDeclarationProtocol {
        static let method: Endpoint.RequestMethod = .post
        static let path = "employees"
    }
}
