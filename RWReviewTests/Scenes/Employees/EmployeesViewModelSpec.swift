//
//  EmployeesViewModelSpec.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RWReview

class EmployeesViewModelSpec: QuickSpec {
    
    override func spec() {
        
        // MARK: - Subject under test
        
        var sut: EmployeesViewModel!
        
        // MARK: - Test Doubles
        
        var employeesRepositoryProviderMock: EmployeesRepositoryProviderMock!
        
        // MARK: - Test setup
        
        beforeEach {
            employeesRepositoryProviderMock = EmployeesRepositoryProviderMock()
            employeesRepositoryProviderMock.getEmployeesRepositoryResult = EmployeesRepositoryMock()
            sut = EmployeesViewModel(employeesRepositoryProvider: employeesRepositoryProviderMock)
        }
        
        // MARK: - Tests
        
        describe("function fetchEmployees") {
            
            it("should set true to isLoading property") {
                // Given
                employeesRepositoryProviderMock.getEmployeesRepositoryResult.fetchEmployeesResult = (employees: [], error: nil)
                // When
                sut.fetchEmployees()
                // Then
                expect(sut.isLoading).to(beTrue())
            }
            
            it("should ask employees repository provider to call get employees repository function") {
                // Given
                employeesRepositoryProviderMock.getEmployeesRepositoryResult.fetchEmployeesResult = (employees: [], error: nil)
                // When
                sut.fetchEmployees()
                // Then
                expect(employeesRepositoryProviderMock.getEmployeesRepositoryCalled).to(beTrue())
            }
            
            it("should ask repository to call fetchEmployees function") {
                // Given
                let repository = employeesRepositoryProviderMock.getEmployeesRepositoryResult
                repository?.fetchEmployeesResult = (employees: [], error: nil)
                // When
                sut.fetchEmployees()
                // Then
                expect(repository?.fetchEmployeesCalled).to(beTrue())
            }
            
            context("when fetchEmployees failed") {
                
                let error = DummyError()
                
                beforeEach {
                    employeesRepositoryProviderMock.getEmployeesRepositoryResult.fetchEmployeesResult = (employees: [], error: error)
                }
                
                it("should set false to isLoading property") {
                    // Given
                    // When
                    sut.fetchEmployees()
                    // Then
                    expect(sut.isLoading).to(beFalse())
                }
                
                it("should set alert value where message is error description") {
                    // Given
                    // When
                    sut.fetchEmployees()
                    // Then
                    expect(sut.alert).notTo(beNil())
                    expect(sut.alert?.message).to(equal(error.localizedDescription))
                }
            }
            
            context("when fetchEmployees succeeded") {
                
                var activeEmployee = Seeds.employee
                activeEmployee.isActive = true
                
                var inactiveEmployee = Seeds.employee
                inactiveEmployee.isActive = false
                
                let employees = [activeEmployee, inactiveEmployee]
                
                beforeEach {
                    employeesRepositoryProviderMock.getEmployeesRepositoryResult.fetchEmployeesResult = (employees: employees, error: nil)
                }
                
                it("should set false to isLoading property") {
                    // Given
                    // When
                    sut.fetchEmployees()
                    // Then
                    expect(sut.isLoading).to(beFalse())
                }
                
                it("should set fetched employees to employees property") {
                    // Given
                    // When
                    sut.fetchEmployees()
                    // Then
                    expect(sut.employees.count).to(equal(employees.count))
                    let expectedEmployeeViewModel = EmployeeViewModel(employee: employees[0])
                    expect(sut.employees.first).to(equal(expectedEmployeeViewModel))
                }
                
                it("should filter employees by isActive property") {
                    // Given
                    // When
                    sut.fetchEmployees()
                    // Then
                    let expectedActiveEmployees = [EmployeeViewModel(employee: activeEmployee)]
                    expect(sut.activeEmployees).to(equal(expectedActiveEmployees))
                    let expectedInactiveEmployees = [EmployeeViewModel(employee: inactiveEmployee)]
                    expect(sut.inactiveEmployees).to(equal(expectedInactiveEmployees))
                }
            }
        }
        
        describe("function employeeCreated") {
                
            it("should add new employee to employees array") {
                // Given
                sut.employees = [EmployeeViewModel(employee: Seeds.employee)]
                let employeesCount = sut.employees.count
                var newEmployee = Seeds.employee
                newEmployee.firstName = "New employee"
                let newEmployeeViewModel = EmployeeViewModel(employee: newEmployee)
                // When
                sut.employeeCreated(newEmployeeViewModel)
                // Then
                expect(sut.employees.last).to(equal(newEmployeeViewModel))
                expect(sut.employees.count).to(equal(employeesCount + 1))
            }
        }
    }
}

extension EmployeeViewModel.Role: Equatable {
    public static func == (lhs: EmployeeViewModel.Role, rhs: EmployeeViewModel.Role) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.uppercasedName == rhs.uppercasedName
    }
}

extension EmployeeViewModel: Equatable {
    public static func == (lhs: EmployeeViewModel, rhs: EmployeeViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.fullName == rhs.fullName &&
            lhs.isActive == rhs.isActive &&
            lhs.profilePictureURL == rhs.profilePictureURL &&
            lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.role == rhs.role &&
            lhs.details == rhs.details
    }
}

extension EmployeeViewModel.Details: Equatable {
    public static func == (lhs: EmployeeViewModel.Details, rhs: EmployeeViewModel.Details) -> Bool {
        return lhs.birthDate == rhs.birthDate &&
            lhs.birthDateDescription == rhs.birthDateDescription &&
            lhs.email == rhs.email &&
            lhs.phone == rhs.phone &&
            lhs.startDate == rhs.startDate &&
            lhs.startDateDescription == rhs.startDateDescription
    }
}
