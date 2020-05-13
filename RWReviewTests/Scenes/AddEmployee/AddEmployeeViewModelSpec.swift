//
//  AddEmployeeViewModelSpec.swift
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

class AddEmoployeeViewModelSpec: QuickSpec {
    
    override func spec() {
        
        // MARK: - Subject under test
        
        var sut: AddEmployeeViewModel!
        
        // MARK: - Test Doubles
        
        var employeesRepositoryProviderMock: EmployeesRepositoryProviderMock!
        var validatorMock: ValidatorMock!
        var phoneNumberKitMock: PhoneNumberKitMock!
        var delegateMock: AddEmployeeDelegateMock!
        
        // MARK: - Test setup
        
        beforeEach {
            employeesRepositoryProviderMock = EmployeesRepositoryProviderMock()
            employeesRepositoryProviderMock.getEmployeesRepositoryResult = EmployeesRepositoryMock()
            validatorMock = ValidatorMock()
            delegateMock = AddEmployeeDelegateMock()
            phoneNumberKitMock = PhoneNumberKitMock()
        }
        
        // MARK: - Tests
        
        describe("property startDate") {
            
            context("when receive value") {
                
                it("should set nil to startDateErrorDescription property") {
                    // Given
                    sut = AddEmployeeViewModel(delegate: nil)
                    sut.startDateErrorDescription = "error_description"
                    // When
                    sut.startDate = Date()
                    // Then
                    expect(sut.startDateErrorDescription).to(beNil())
                }
            }
        }
        
        describe("function validateSelectionFields") {
            
            beforeEach {
                sut = AddEmployeeViewModel(delegate: nil)
            }
            
            context("when startDate is selected") {
                
                it("should set nil to startDateErrorDescription property") {
                    // Given
                    sut.startDate = Date()
                    // When
                    sut.validateSelectionFields()
                    // Then
                    expect(sut.startDateErrorDescription).to(beNil())
                }
            }
            
            context("when startDate is not selected") {
                
                it("should set error description to startDateErrorDescription property") {
                    // Given
                    sut.startDate = nil
                    // When
                    sut.validateSelectionFields()
                    // Then
                    let expectedErrorDescription = EmployeeError.startDateNotSelected.localizedDescription
                    expect(sut.startDateErrorDescription).to(equal(expectedErrorDescription))
                }
            }
        }
        
        describe("property validationResult") {
            
            beforeEach {
                sut = AddEmployeeViewModel(delegate: nil)
            }
            
            context("when all validation errors are nil") {
                
                it("should return success") {
                    // Given
                    sut.emailErrorDescription = nil
                    sut.firstNameErrorDescription = nil
                    sut.lastNameErrorDescription = nil
                    sut.phoneErrorDescription = nil
                    sut.startDateErrorDescription = nil
                    // When
                    let result = sut.validationResult
                    // Then
                    expect(result).to(equal(.success))
                }
            }
            
            context("when at least one validation error is not nil") {
                
                it("should return failure") {
                    // Given
                    sut.emailErrorDescription = "email_error"
                    sut.firstNameErrorDescription = nil
                    sut.lastNameErrorDescription = nil
                    sut.phoneErrorDescription = "phone_error"
                    sut.startDateErrorDescription = nil
                    // When
                    let result = sut.validationResult
                    // Then
                    expect(result).to(equal(.failure))
                }
            }
        }
        
        describe("function validateTextFields") {
            
            beforeEach {
                sut = AddEmployeeViewModel(delegate: nil, validator: validatorMock)
                validatorMock.validateResult = [DummyError()]
            }
            
            it("should ask validator to call validate function 4 times") {
                // Given
                sut.phone = "+1 (519) 222-5555"
                // When
                sut.validateTextFields()
                // Then
                expect(validatorMock.validateInvocations.count).to(equal(4))
            }
            
            context("when validate function is called for the first time") {
                
                it("should pass validation rules as argument to validate function") {
                    // Given
                    // When
                    sut.validateTextFields()
                    // Then
                    let expectedRules = [RequiredValidationRule(error: EmployeeError.blankFirstName)]
                    let rules = validatorMock.validateInvocations.arguments[0].rules
                    expect(rules.count).to(equal(expectedRules.count))
                    for (index, rule) in rules.enumerated() {
                        expect(rule.error.localizedDescription).to(equal(expectedRules[index].error.localizedDescription))
                    }
                    expect(rules[0]).to(beAnInstanceOf(RequiredValidationRule.self))
                }
                
                it("should pass firstName as argument to validate function") {
                    // Given
                    let firstName = "John"
                    sut.firstName = firstName
                    // When
                    sut.validateTextFields()
                    // Then
                    expect(validatorMock.validateInvocations.arguments[0].input).to(equal(firstName))
                }
                
                it("should set description of first firstName error to firstNameErrorDescription property") {
                    // Given
                    // When
                    sut.validateTextFields()
                    // Then
                    let expectedError = validatorMock.validateResult.first
                    expect(sut.firstNameErrorDescription).to(equal(expectedError?.localizedDescription))
                }
            }
            
            context("when validate function is called for the second time") {
                
                it("should pass validation rules as argument to validate function") {
                    // Given
                    // When
                    sut.validateTextFields()
                    // Then
                    let expectedRules = [RequiredValidationRule(error: EmployeeError.blankLastName)]
                    let rules = validatorMock.validateInvocations.arguments[1].rules
                    expect(rules.count).to(equal(expectedRules.count))
                    for (index, rule) in rules.enumerated() {
                        expect(rule.error.localizedDescription).to(equal(expectedRules[index].error.localizedDescription))
                    }
                    expect(rules[0]).to(beAnInstanceOf(RequiredValidationRule.self))
                }
                
                it("should pass lastName as argument to validate function") {
                    // Given
                    let lastName = "Doe"
                    sut.lastName = lastName
                    // When
                    sut.validateTextFields()
                    // Then
                    expect(validatorMock.validateInvocations.arguments[1].input).to(equal(lastName))
                }
                
                it("should set description of first lastName error to lastNameErrorDescription property") {
                    // Given
                    // When
                    sut.validateTextFields()
                    // Then
                    let expectedError = validatorMock.validateResult.first
                    expect(sut.lastNameErrorDescription).to(equal(expectedError?.localizedDescription))
                }
            }
            
            context("when validate function is called for the third time") {
                
                it("should pass validation rules as argument to validate function") {
                    // Given
                    // When
                    sut.validateTextFields()
                    // Then
                    let expectedRules: [ValidationRule] = [
                        RequiredValidationRule(error: EmployeeError.blankEmail),
                        EmailValidationRule(error: EmployeeError.invalidEmail)
                    ]
                    let rules = validatorMock.validateInvocations.arguments[2].rules
                    expect(rules.count).to(equal(expectedRules.count))
                    for (index, rule) in rules.enumerated() {
                        expect(rule.error.localizedDescription).to(equal(expectedRules[index].error.localizedDescription))
                    }
                    expect(rules[0]).to(beAnInstanceOf(RequiredValidationRule.self))
                    expect(rules[1]).to(beAnInstanceOf(EmailValidationRule.self))
                }
                
                it("should pass email as argument to validate function") {
                    // Given
                    let email = "example_email@gmail.com"
                    sut.email = email
                    // When
                    sut.validateTextFields()
                    // Then
                    expect(validatorMock.validateInvocations.arguments[2].input).to(equal(email))
                }
                
                it("should set description of first email error to emailErrorDescription property") {
                    // Given
                    // When
                    sut.validateTextFields()
                    // Then
                    let expectedError = validatorMock.validateResult.first
                    expect(sut.emailErrorDescription).to(equal(expectedError?.localizedDescription))
                }
            }
            
            context("when validate function is called for the fourth time") {
                
                let phone = "+1 (519) 222-5555"
                
                beforeEach {
                    sut.phone = phone
                }
                
                it("should pass validation rules as argument to validate function") {
                    // Given
                    // When
                    sut.validateTextFields()
                    // Then
                    let expectedRules = [PhoneNumberValidationRule(error: EmployeeError.invalidPhone)]
                    let rules = validatorMock.validateInvocations.arguments[3].rules
                    expect(rules.count).to(equal(expectedRules.count))
                    for (index, rule) in rules.enumerated() {
                        expect(rule.error.localizedDescription).to(equal(expectedRules[index].error.localizedDescription))
                    }
                    expect(rules[0]).to(beAnInstanceOf(PhoneNumberValidationRule.self))
                }
                                
                it("should pass phone as argument to validate function") {
                    // Given
                    // When
                    sut.validateTextFields()
                    // Then
                    expect(validatorMock.validateInvocations.arguments[3].input).to(equal(phone))
                }
                                
                it("should set description of first phone error to phoneErrorDescription property") {
                    // Given
                    // When
                    sut.validateTextFields()
                    // Then
                    let expectedError = validatorMock.validateResult.first
                    expect(sut.phoneErrorDescription).to(equal(expectedError?.localizedDescription))
                }
            }
        }
        
        describe("function configureEncodableEmployee") {
            
            beforeEach {
                sut = AddEmployeeViewModel(delegate: nil, phoneNumberKit: phoneNumberKitMock)
            }
            
            it("shold ask phoneNumnerKit to call parse function") {
                // Given
                // When
                sut.configureEncodableEmployee()
                // Then
                expect(phoneNumberKitMock.parseCalled).to(beTrue())
            }
            
            it("shold pass phone as parse function argument") {
                // Given
                let phone = "+1 (519) 222-5555"
                sut.phone = phone
                // When
                sut.configureEncodableEmployee()
                // Then
                expect(phoneNumberKitMock.parseArgument).to(equal(phone))
            }
            
            it("shold set value to encodableEmployee property") {
                // Given
                // When
                sut.configureEncodableEmployee()
                // Then
                expect(sut.encodableEmployee).notTo(beNil())
            }
        }
        
        describe("function createEmployee") {
            
            let encodableEmployee = Seeds.encodableEmployee
            
            beforeEach {
                sut = AddEmployeeViewModel(delegate: delegateMock, employeesRepositoryProvider: employeesRepositoryProviderMock)
                sut.encodableEmployee = encodableEmployee
                sut.isLoading = false
            }
            
            it("should set true to isLoading property") {
                // Given
                employeesRepositoryProviderMock.getEmployeesRepositoryResult.createEmployeeResult = (employee: nil, error: nil)
                // When
                sut.createEmployee()
                // Then
                expect(sut.isLoading).to(beTrue())
            }
            
            it("should ask employees repository provider to call get employees repository function") {
                // Given
                employeesRepositoryProviderMock.getEmployeesRepositoryResult.createEmployeeResult = (employee: nil, error: nil)
                // When
                sut.createEmployee()
                // Then
                expect(employeesRepositoryProviderMock.getEmployeesRepositoryCalled).to(beTrue())
            }
            
            it("should ask repository to call createEmployee function") {
                // Given
                let repository = employeesRepositoryProviderMock.getEmployeesRepositoryResult
                repository?.createEmployeeResult = (employee: nil, error: nil)
                // When
                sut.createEmployee()
                // Then
                expect(repository?.createEmployeeCalled).to(beTrue())
            }
            
            context("when createEmployee failed") {
                
                let error = DummyError()
                
                beforeEach {
                    employeesRepositoryProviderMock.getEmployeesRepositoryResult.createEmployeeResult = (employee: nil, error: error)
                }
                
                it("should set false to isLoading property") {
                    // Given
                    // When
                    sut.createEmployee()
                    // Then
                    expect(sut.isLoading).to(beFalse())
                }
                
                it("should set alert value where message is error description") {
                    // Given
                    // When
                    sut.createEmployee()
                    // Then
                    expect(sut.alert).notTo(beNil())
                    expect(sut.alert?.message).to(equal(error.localizedDescription))
                }
            }
            
            context("when createEmployee succeeded") {
                
                let employee = Seeds.employee
                
                beforeEach {
                     employeesRepositoryProviderMock.getEmployeesRepositoryResult.createEmployeeResult = (employee: employee, error: nil)
                }
                
                it("should set false to isLoading property") {
                    // Given
                    // When
                    sut.createEmployee()
                    // Then
                    expect(sut.isLoading).to(beFalse())
                }
                
                it("should set true to shouldDismissView property") {
                    // Given
                    // When
                    sut.createEmployee()
                    // Then
                    expect(sut.shouldDismissView).to(beTrue())
                }
                
                it("should ask delegate to call employeeCreated function") {
                    // Given
                    // When
                    sut.createEmployee()
                    // Then
                    expect(delegateMock.employeeCreatedCalled).to(beTrue())
                }
                
                it("should pass employee as argument to employeeCreated function") {
                    // Given
                    // When
                    sut.createEmployee()
                    // Then
                    let employeeViewModel = EmployeeViewModel(employee: employee)
                    expect(delegateMock.employeeCreatedArgument).to(equal(employeeViewModel))
                }
            }
        }
    }
}
