//
//  EmployeeViewModelSpec.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import Quick
import Nimble
import PhoneNumberKit
@testable import RWReview

class EmployeeViewModelSpec: QuickSpec {

    override func spec() {
    
        // MARK: - Subject under test
        
        var sut: EmployeeViewModel!
        
        // MARK: - Test setup
        
        var employee: Employee!
        
        beforeEach {
            employee = Seeds.employee
        }
        
        // MARK: - Tests
        
        it("property id should return formatted value") {
            // Given
            employee.id = 3
            sut = EmployeeViewModel(employee: employee)
            // When
            let result = sut.id
            // Then
            expect(result).to(equal(3))
        }
        
        it("property firstName should return formatted value") {
            // Given
            let firstName = "Diana"
            employee.firstName = firstName
            sut = EmployeeViewModel(employee: employee)
            // When
            let result = sut.firstName
            // Then
            expect(result).to(equal(firstName))
        }
        
        it("property lastName should return formatted value") {
            // Given
            let lastName = "Boo"
            employee.lastName = lastName
            sut = EmployeeViewModel(employee: employee)
            // When
            let result = sut.lastName
            // Then
            expect(result).to(equal(lastName))
        }
            
        it("property isActive should return formatted value") {
            // Given
            employee.isActive = true
            sut = EmployeeViewModel(employee: employee)
            // When
            let result = sut.isActive
            // Then
            expect(result).to(beTrue())
        }
        
        it("property profilePictureURL should return formatted value") {
            // Given
            let profilePictureURL = "http://domain/profile_url/avatar.png"
            employee.profilePictureURL = profilePictureURL
            sut = EmployeeViewModel(employee: employee)
            // When
            let result = sut.profilePictureURL
            // Then
            expect(result?.absoluteString).to(equal(profilePictureURL))
        }
        
        describe("property fullName") {
            
            context("when firstName is empty") {
                
                it("should return formatted value") {
                    // Given
                    employee.firstName = ""
                    employee.lastName = "Bing"
                    sut = EmployeeViewModel(employee: employee)
                    // When
                    let result = sut.fullName
                    // Then
                    expect(result).to(equal("Bing"))
                }
            }
            
            context("when lastName is empty") {
                
                it("should return formatted value") {
                    // Given
                    employee.firstName = "Diana"
                    employee.lastName = ""
                    sut = EmployeeViewModel(employee: employee)
                    // When
                    let result = sut.fullName
                    // Then
                    expect(result).to(equal("Diana"))
                }
            }
            
            context("when firstName and lastName are empty") {
                
                it("should return formatted value") {
                    // Given
                    employee.firstName = ""
                    employee.lastName = ""
                    sut = EmployeeViewModel(employee: employee)
                    // When
                    let result = sut.fullName
                    // Then
                    expect(result).to(beEmpty())
                }
            }
            
            context("when firstName and lastName are not empty") {
                
                it("should return formatted value") {
                    // Given
                    employee.firstName = "Diana"
                    employee.lastName = "Bing"
                    sut = EmployeeViewModel(employee: employee)
                    // When
                    let result = sut.fullName
                    // Then
                    expect(result).to(equal("Diana Bing"))
                }
            }
        }
        
        it("function complete should add details to employee") {
            // Given
            let details = Seeds.employeeDetails
            sut = EmployeeViewModel(employee: employee)
            // When
            sut.complete(with: details)
            // Then
            expect(sut.details).notTo(beNil())
        }
        
        describe("property details") {

            context("when employee details is nil") {

                it("should return nil") {
                    // Given
                    employee.details = nil
                    sut = EmployeeViewModel(employee: employee)
                    // When
                    let result = sut.details
                    // Then
                    expect(result).to(beNil())
                }
            }

            context("when employee details is not nil") {

                it("should return emoloyee details view model") {
                    // Given
                    employee.details = Seeds.employeeDetails
                    sut = EmployeeViewModel(employee: employee)
                    // When
                    let result = sut.details
                    // Then
                    expect(result).notTo(beNil())
                }
            }
        }
        
        describe("property role") {

            context("when employee role is nil") {

                it("should return nil") {
                    // Given
                    employee.role = nil
                    sut = EmployeeViewModel(employee: employee)
                    // When
                    let result = sut.role
                    // Then
                    expect(result).to(beNil())
                }
            }

            context("when employee role is not nil") {

                it("should return emoloyee role view model") {
                    // Given
                    employee.role = Seeds.employeeRole
                    sut = EmployeeViewModel(employee: employee)
                    // When
                    let result = sut.role
                    // Then
                    expect(result).notTo(beNil())
                }
            }
        }
    }
}

class EmployeeViewModelDetailsSpec: QuickSpec {

    override func spec() {

        // MARK: - Subject under test
        
        var sut: EmployeeViewModel.Details!
        
        // MARK: - Test setup
        
        var details: Employee.Details!
        
        beforeEach {
            details = Seeds.employeeDetails
        }
        
        // MARK: - Tests
        
        it("property email should return formatted value") {
            // Given
            let email = "example@example.com"
            details.email = email
            sut = EmployeeViewModel.Details(details: details)
            // When
            let result = sut.email
            // Then
            expect(result).to(equal(email))
        }
        
        describe("property phone") {
            
            let phoneNumberKitMock = PhoneNumberKitMock()
            
            context("when employee details phone is nil") {
                
                it("should return nil") {
                    // Given
                    details.phone = nil
                    sut = EmployeeViewModel.Details(details: details)
                    // When
                    let result = sut.phone
                    // Then
                    expect(result).to(beNil())
                }
            }
            
            context("when employee details phone is not nil") {
                
                it("shold ask phoneNumnerKit to call parse function") {
                    // Given
                    sut = EmployeeViewModel.Details(details: details, phoneNumberKit: phoneNumberKitMock)
                    // When
                    _ = sut.phone
                    // Then
                    expect(phoneNumberKitMock.parseCalled).to(beTrue())
                }
                
                it("shold pass phone as parse function argument") {
                    // Given
                    let phone = "example_phone_number"
                    details.phone = phone
                    sut = EmployeeViewModel.Details(details: details, phoneNumberKit: phoneNumberKitMock)
                    // When
                     _ = sut.phone
                    // Then
                    expect(phoneNumberKitMock.parseArgument).to(equal(phone))
                }
                
                context("when parse function returns phone number") {
                    
                    let parseResult = PhoneNumberKit().getExampleNumber(forCountry: "CA")
                    let formatResult = "formatted_phone_number"
                    
                    beforeEach {
                        phoneNumberKitMock.parseResult = parseResult
                        phoneNumberKitMock.formatResult = formatResult
                    }
                    
                    it("shold ask phoneNumnerKit to call format function") {
                        // Given
                        sut = EmployeeViewModel.Details(details: details, phoneNumberKit: phoneNumberKitMock)
                        // When
                        _ = sut.phone
                        // Then
                        expect(phoneNumberKitMock.formatCalled).to(beTrue())
                    }
                    
                    it("shold pass parse result as format function argument") {
                        // Given
                        sut = EmployeeViewModel.Details(details: details, phoneNumberKit: phoneNumberKitMock)
                        // When
                         _ = sut.phone
                        // Then
                        expect(phoneNumberKitMock.formatArguments.phoneNumber).to(equal(parseResult))
                    }
                    
                    it("shold pass international as format function argument") {
                        // Given
                        sut = EmployeeViewModel.Details(details: details, phoneNumberKit: phoneNumberKitMock)
                        // When
                         _ = sut.phone
                        // Then
                        expect(phoneNumberKitMock.formatArguments.formatType).to(equal(.international))
                    }
                    
                    it("should return format result") {
                        // Given
                        sut = EmployeeViewModel.Details(details: details, phoneNumberKit: phoneNumberKitMock)
                        // When
                        let result = sut.phone
                        // Then
                        expect(result).to(equal(formatResult))
                    }
                }
                
                context("when parse function throws error") {
                    
                    it("should return formatted value") {
                        // Given
                        phoneNumberKitMock.parseResult = nil
                        let phone = "example_phone_number"
                        details.phone = phone
                        sut = EmployeeViewModel.Details(details: details, phoneNumberKit: phoneNumberKitMock)
                        // When
                        let result = sut.phone
                        // Then
                        expect(result).to(equal(phone))
                    }
                }
            }
        }
        
        it("property startDate should return formatted value") {
            // Given
            let components = DateComponents(year: 2020, month: 3, day: 21)
            let expectedDate = Calendar.current.date(from: components)
            let timeInterval = expectedDate!.timeIntervalSince1970
            details.startDate = timeInterval
            sut = EmployeeViewModel.Details(details: details)
            // When
            let result = sut.startDate
            // Then
            expect(result).to(equal(expectedDate))
        }
        
        describe("property birthDate") {
            
            context("when employee details birthDate is nil") {
                
                it("should return nil") {
                    // Given
                    details.birthDate = nil
                    sut = EmployeeViewModel.Details(details: details)
                    // When
                    let result = sut.birthDate
                    // Then
                    expect(result).to(beNil())
                }
            }
            
            context("when employee details birthDate is not nil") {
                
                it("should return formatted value") {
                    // Given
                    let components = DateComponents(year: 2020, month: 3, day: 21)
                    let expectedDate = Calendar.current.date(from: components)
                    let timeInterval = expectedDate!.timeIntervalSince1970
                    details.birthDate = timeInterval
                    sut = EmployeeViewModel.Details(details: details)
                    // When
                    let result = sut.birthDate
                    // Then
                    expect(result).to(equal(expectedDate))
                }
            }
        }
        
        describe("property birthDateDescription") {
        
            context("when employee details birthDate is nil") {
            
                it("should return nil") {
                    // Given
                    details.birthDate = nil
                    sut = EmployeeViewModel.Details(details: details)
                    // When
                    let result = sut.birthDateDescription
                    // Then
                    expect(result).to(beNil())
                }
            }
            
            context("when employee details birthDate is not nil") {
                
                it("should return formatted value") {
                    // Given
                    details.birthDate = TimeInterval(1615373416)
                    sut = EmployeeViewModel.Details(details: details)
                    // When
                    let result = sut.birthDateDescription
                    // Then
                    expect(result).to(equal("Mar 10, 2021"))
                }
            }
        }
        
        it("property startDateDescription should return formatted value") {
            // Given
            details.startDate = TimeInterval(1615373416)
            sut = EmployeeViewModel.Details(details: details)
            // When
            let result = sut.startDateDescription
            // Then
            expect(result).to(equal("Mar 10, 2021"))
        }
    }
}

class EmployeeViewModelRoleSpec: QuickSpec {

    override func spec() {

        // MARK: - Subject under test
    
        var sut: EmployeeViewModel.Role!
    
        // MARK: - Test setup
    
        var role: Employee.Role!
    
        beforeEach {
            role = Seeds.employeeRole
        }
    
        // MARK: - Tests
        
        it("property id should return formatted value") {
            // Given
            role.id = 3
            sut = EmployeeViewModel.Role(role: role)
            // When
            let result = sut.id
            // Then
            expect(result).to(equal(3))
        }
        
        it("property name should return formatted value") {
            // Given
            let name = "Doctor"
            role.name = name
            sut = EmployeeViewModel.Role(role: role)
            // When
            let result = sut.name
            // Then
            expect(result).to(equal(name))
        }
        
        it("property uppercasedName should return formatted value") {
            // Given
            role.name = "Doctor"
            sut = EmployeeViewModel.Role(role: role)
            // When
            let result = sut.uppercasedName
            // Then
            expect(result).to(equal("DOCTOR"))
        }
    }
}
