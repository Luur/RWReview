//
//  Employee.swift
//  RWReview
//
//  Created by Svyat Zubyak on 12.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Employee {
    var id: Int
    var firstName: String
    var lastName: String
    var profilePictureURL: String
    var isActive: Bool
    var role: Role?
    var details: Details?
    
    init(id: Int, firstName: String, lastName: String, profilePictureURL: String, isActive:  Bool, role: Role?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profilePictureURL = profilePictureURL
        self.isActive = isActive
        self.role = role
    }
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.profilePictureURL = json["avatar"].stringValue
        self.isActive = json["active"].boolValue
        self.role = json["employee_role"] != JSON.null ? Role(json: json["employee_role"]) : nil
    }
    
    static let placeholder = Employee(id: 0, firstName: "John", lastName: "Doe", profilePictureURL: "", isActive: true, role: Role.placeholder)
}

// MARK: - Nested Role Model

extension Employee {

    struct Role {
        var id: Int
        var name: String

        init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
        
        init(json: JSON) {
            self.id = json["id"].intValue
            self.name = json["name"].stringValue
        }

        static let placeholder = Employee.Role(id: 0, name: "Doctor")
    }
}

// MARK: - Nested Details Model

extension Employee {

    struct Details {
        var email: String
        var phone: String?
        var startDate: TimeInterval
        var birthDate: TimeInterval?

        init(email: String, phone: String?, startDate: TimeInterval, birthDate: TimeInterval?) {
            self.email = email
            self.phone = phone
            self.accessLevel = accessLevel
            self.startDate = startDate
            self.birthDate = birthDate
            self.clinicUsers = clinicUsers
        }
        
        init(json: JSON) {
            self.email = json["email"].stringValue
            self.phone = json["phone"].string
            self.startDate = json["start_date"].doubleValue
            self.birthDate = json["date_of_birth"].double
        }

        static let placeholder = Employee.Details(email: "john.doe@gmail.com", phone: "5192222222", startDate: TimeInterval(1579515648), birthDate: TimeInterval(1552514348))
    }
}
