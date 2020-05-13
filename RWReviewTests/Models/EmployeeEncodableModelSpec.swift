//
//  EmployeeEncodableModelSpec.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import RWReview

class EmployeeEncodableModelSpec: QuickSpec {

    override func spec() {
    
        // MARK: - Subject under test
    
        var sut: EmployeeEncodableModel!
    
        // MARK: - Tests
        
        describe("initialization") {
            
            let firstName = "Bob"
            let lastName = "Bing"
            let startDate = Date()
            let birthDate = Date()
            let email = "test@test.com"
            let phone: UInt64 = 5192225555
            
                
            it("should be able to initialize correctly") {
                // Given
                // When
                sut = EmployeeEncodableModel(firstName: firstName, lastName: lastName, startDate: startDate, birthDate: birthDate, email: email, phone: phone, image: nil)
                // Then
                expect(sut).notTo(beNil())
                expect(sut.firstName).to(equal(firstName))
                expect(sut.lastName).to(equal(lastName))
                expect(sut.startDate).to(equal(startDate))
                expect(sut.birthDate).to(equal(birthDate))
                expect(sut.email).to(equal(email))
                expect(sut.phone).to(equal(phone))
            }
            
            context("when image is provided") {
                
                it("should be able to initialize avatar property") {
                    // Given
                    let image = UIImage(systemName: "gamecontroller")
                    // When
                    sut = EmployeeEncodableModel(firstName: firstName, lastName: lastName, startDate: startDate, birthDate: nil, email: email, phone: nil, image: image)
                    // Then
                    expect(sut.avatar).notTo(beNil())
                    expect(sut.avatar?.data.hasPrefix("data:image/jpeg;base64,")).to(beTrue())
                }
            }
        }
    }
}
