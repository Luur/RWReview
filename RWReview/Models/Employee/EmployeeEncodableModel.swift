//
//  EmployeeEncodableModel.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import UIKit

struct EmployeeEncodableModel: Encodable {
    var firstName: String
    var lastName: String
    var startDate: Date?
    var birthDate: Date?
    var email: String
    var phone: UInt64?
    var avatar: Avatar?
    
    struct Avatar: Encodable {
        var data: String
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case startDate = "start_date"
        case birthDate = "date_of_birth"
        case email
        case phone
        case avatar
    }
    
    init(
        firstName: String,
        lastName: String,
        startDate: Date?,
        birthDate: Date?,
        email: String,
        phone: UInt64?,
        image: UIImage?
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.startDate = startDate
        self.birthDate = birthDate
        
        let data = image?.jpegData(compressionQuality: 0.5)
        if let base64EncodedString = data?.base64EncodedString() {
            self.avatar = Avatar(data: "data:image/jpeg;base64," + base64EncodedString)
        }
    }
}
