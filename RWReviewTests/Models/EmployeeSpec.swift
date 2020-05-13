//
//  EmployeeSpec.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftyJSON
@testable import RWReview

class EmployeeSpec: QuickSpec {

    override func spec() {
    
        // MARK: - Subject under test
    
        var sut: Employee!
    
        // MARK: - Tests
        
        describe("initialization") {
            
            let id = 56
            let firstName = "Bob"
            let lastName = "Bing"
            let profilePictureURL = "https://domain/profile_picture.png"
            let isActive = true
            
            context("when init is default") {
                
                it("should be able to initialize correctly") {
                    // Given
                    let role = Seeds.employeeRole
                    // When
                    sut = Employee(id: id, firstName: firstName, lastName: lastName, profilePictureURL: profilePictureURL, isActive: isActive, role: role)
                    // Then
                    expect(sut).notTo(beNil())
                    expect(sut.id).to(equal(id))
                    expect(sut.firstName).to(equal(firstName))
                    expect(sut.lastName).to(equal(lastName))
                    expect(sut.profilePictureURL).to(equal(profilePictureURL))
                    expect(sut.isActive).to(equal(isActive))
                    expect(sut.role).to(equal(role))
                }
            }
            
            context("when init with json") {
                
                it("should be able to initialize correctly") {
                    // Given
                    let json = JSON(Responses.Employee(id: id, firstName: firstName, lastName: lastName, profilePictureURL: profilePictureURL, isActive: isActive).encoded)
                    // When
                    sut = Employee(json: json)
                    // Then
                    expect(sut).notTo(beNil())
                    expect(sut.id).to(equal(id))
                    expect(sut.firstName).to(equal(firstName))
                    expect(sut.lastName).to(equal(lastName))
                    expect(sut.profilePictureURL).to(equal(profilePictureURL))
                    expect(sut.isActive).to(equal(isActive))
                }
            }
        }
    }
}

class EmployeeRoleSpec: QuickSpec {

    override func spec() {
    
        // MARK: - Subject under test
    
        var sut: Employee.Role!
    
        // MARK: - Tests
        
        describe("initialization") {
            
            let id = 56
            let name = "Doctor"
            
            context("when init is default") {
                
                it("should be able to initialize correctly") {
                    // Given
                    // When
                    sut = Employee.Role(id: id, name: name)
                    // Then
                    expect(sut).notTo(beNil())
                    expect(sut.id).to(equal(id))
                    expect(sut.name).to(equal(name))
                }
            }
            
            context("when init with json") {
                
                it("should be able to initialize correctly") {
                    // Given
                    let json = JSON(Responses.Employee.Role(id: id, name: name).encoded)
                    // When
                    sut = Employee.Role(json: json)
                    // Then
                    expect(sut).notTo(beNil())
                    expect(sut.id).to(equal(id))
                    expect(sut.name).to(equal(name))
                }
            }
        }
    }
}

class EmployeeDetailsSpec: QuickSpec {

    override func spec() {
    
        // MARK: - Subject under test
    
        var sut: Employee.Details!
    
        // MARK: - Tests
        
        describe("initialization") {
            
            let email = "email@email.com"
            let phone = "0968348176"
            let startDate = TimeInterval(1579515648.0)
            let birthDate = TimeInterval(1552514348.0)
            
            context("when init is default") {
                
                it("should be able to initialize correctly") {
                    // Given
                    // When
                    sut = Employee.Details(email: email, phone: phone, startDate: startDate, birthDate: birthDate)
                    // Then
                    expect(sut).notTo(beNil())
                    expect(sut.email).to(equal(email))
                    expect(sut.phone).to(equal(phone))
                    expect(sut.startDate).to(equal(startDate))
                    expect(sut.birthDate).to(equal(birthDate))
                }
            }
            
            context("when init with json") {
                
                it("should be able to initialize correctly") {
                    // Given
                    let json = JSON(Responses.Employee.Details(email: email, phone: phone, startDate: startDate, birthDate: birthDate).encoded)
                    // When
                    sut = Employee.Details(json: json)
                    // Then
                    expect(sut).notTo(beNil())
                    expect(sut.email).to(equal(email))
                    expect(sut.phone).to(equal(phone))
                    expect(sut.startDate).to(equal(startDate))
                    expect(sut.birthDate).to(equal(birthDate))
                }
            }
        }
    }
}

extension Employee.Role: Equatable {
    public static func == (lhs: Employee.Role, rhs: Employee.Role) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name
    }
}
