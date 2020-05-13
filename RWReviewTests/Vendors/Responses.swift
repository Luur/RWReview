//
//  Responses.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
@testable import RWReview

struct Responses {
    
    struct Employee: Codable {
        var id: Int
        var firstName: String
        var lastName: String
        var profilePictureURL: String
        var isActive: Bool
        
        init(id: Int, firstName: String, lastName: String, profilePictureURL: String, isActive: Bool) {
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.profilePictureURL = profilePictureURL
            self.isActive = isActive
        }

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case firstName = "first_name"
            case lastName = "last_name"
            case profilePictureURL = "avatar"
            case isActive = "active"
        }
        
        struct Role: Codable {
            var id: Int
            var name: String
            
            init(id: Int, name: String) {
                self.id = id
                self.name = name
            }
        }
        
        struct Details: Codable {
            var email: String
            var phone: String
            var startDate: Double
            var birthDate: Double
            
            init(email: String, phone: String, startDate: Double, birthDate: Double) {
                self.email = email
                self.phone = phone
                self.startDate = startDate
                self.birthDate = birthDate
            }
            
            enum CodingKeys: String, CodingKey {
                case email
                case phone
                case startDate = "start_date"
                case birthDate = "date_of_birth"
            }
        }
    }
}
