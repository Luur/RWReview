//
//  EmployeeViewModel.swift
//  RWReview
//
//  Created by Svyat Zubyak on 12.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import PhoneNumberKit

struct EmployeeViewModel: Identifiable {

    private var employee: Employee

    init(employee: Employee) {
        self.employee = employee
    }
    
    var id: Int {
        employee.id
    }
    
    var firstName: String {
        employee.firstName
    }
    
    var lastName: String {
        employee.lastName
    }

    var fullName: String {
        let fullName = "\(employee.firstName) \(employee.lastName)"
        return fullName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var profilePictureURL: URL? {
        URL(string: employee.profilePictureURL)
    }
    
    var isActive: Bool {
        employee.isActive
    }
    
    var role: Role? {
        guard let role = employee.role else { return nil }
        return Role(role: role)
    }
    
    var details: Details? {
        guard let details = employee.details else { return nil }
        return Details(details: details)
    }
    
    mutating func complete(with details: Employee.Details) {
        employee.details = details
    }
}

// MARK: - Nested Role ViewModel

extension EmployeeViewModel {
    
    struct Role: Identifiable {
        
        private var role: Employee.Role
        
        init(role: Employee.Role) {
            self.role = role
        }
        
        var id: Int {
            role.id
        }
        
        var name: String {
            role.name
        }
        
        var uppercasedName: String {
            role.name.uppercased()
        }
    }
}

// MARK: - Nested Details ViewModel

extension EmployeeViewModel {

    struct Details {

        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }()

        private var phoneNumberKit: PhoneNumberKitProtocol
        private var details: Employee.Details

        init(details: Employee.Details, phoneNumberKit: PhoneNumberKitProtocol = PhoneNumberKit()) {
            self.details = details
            self.phoneNumberKit = phoneNumberKit
        }

        var email: String {
            details.email
        }

        var phone: String? {
            guard let phone = details.phone else { return nil }
            guard let phoneNumber = try? phoneNumberKit.parse(phone) else { return phone }
            return phoneNumberKit.format(phoneNumber, toType: .international)
        }
        
        var startDate: Date {
            Date(timeIntervalSince1970: details.startDate)
        }

        var startDateDescription: String {
            let date = Date(timeIntervalSince1970: details.startDate)
            return dateFormatter.string(from: date)
        }
        
        var birthDate: Date? {
            guard let birthDate = details.birthDate else { return nil }
            return Date(timeIntervalSince1970: birthDate)
        }

        var birthDateDescription: String? {
            guard let birthDate = details.birthDate else { return nil }
            let date = Date(timeIntervalSince1970: birthDate)
            return dateFormatter.string(from: date)
        }
    }
}
