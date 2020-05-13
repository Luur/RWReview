//
//  EmployeeWebRepositorySpec.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RWReview

class EmployeesWebRepositorySpec: QuickSpec {
    
    override func spec() {
        
        // MARK: - Subject under test
        
        var sut: EmployeesWebRepository!
        
        // MARK: - Test Doubles
        
        var environmentMock: EnvirontmentMock!
        
        // MARK: - Test setup
        
        beforeEach {
            environmentMock = EnvirontmentMock(name: "Mockup", type: .Mock)
            sut = EmployeesWebRepository(environment: environmentMock)
        }
        
        // MARK: - Tests
        
        describe("function fetchEmployees") {
            
            it("should ask environment to call authorized request function") {
                // Given
                // When
                sut.fetchEmployees { _ in }
                // Then
                expect(environmentMock.authorizedRequestCalled).to(beTrue())
            }
            
            it("should pass request method as argument to environment authorized request function") {
                // Given
                // When
                sut.fetchEmployees { _ in }
                // Then
                expect(environmentMock.authorizedRequestArguments.requestMethod).to(equal(EmployeesEndpoint.FetchEmployees.method))
            }
            
            it("should pass path as argument to environment authorized request function") {
                // Given
                // When
                sut.fetchEmployees { _ in }
                // Then
                expect(environmentMock.authorizedRequestArguments.path).to(equal(EmployeesEndpoint.FetchEmployees.path))
            }
            
            context("when success closure called") {
                
                context("when status code class is success") {
                    
                    it("should call success completion") {
                        // Given
                        environmentMock.authorizedRequestResult = (success: (json: [:], statusCode: 200), error: nil)
                        var isSuccessCompletionCalled: Bool = false
                        // When
                        sut.fetchEmployees { result in
                            switch result {
                            case .success:
                                isSuccessCompletionCalled = true
                            case .failure(_):
                                fail("should not execute failure case")
                            }
                        }
                        // Then
                        expect(isSuccessCompletionCalled).to(beTrue())
                    }
                }
                
                context("when status code class is client error") {
                    
                    it("should call failure completion with error") {
                        // Given
                        environmentMock.authorizedRequestResult = (success: (json: [:], statusCode: 500), error: nil)
                        var fetchEmployeesError: Error?
                        // When
                        sut.fetchEmployees { result in
                            switch result {
                            case .success:
                                fail("should not execute success case")
                            case .failure(let error):
                                fetchEmployeesError = error
                            }
                        }
                        // Then
                        expect(fetchEmployeesError).notTo(beNil())
                    }
                }
            }
            
            context("when failure closure called") {
                
                it("should call failure completion with error") {
                    // Given
                    environmentMock.authorizedRequestResult = (success: nil, error: DummyError())
                    var fetchEmployeesError: Error?
                    // When
                    sut.fetchEmployees { result in
                        switch result {
                        case .success:
                            fail("should not execute success case")
                        case .failure(let error):
                            fetchEmployeesError = error
                        }
                    }
                    // Then
                    expect(fetchEmployeesError).notTo(beNil())
                }
            }
        }
        
        describe("function fetchEmployeeDetails") {
            
            it("should ask environment to call authorized request function") {
                // Given
                // When
                sut.fetchEmployeeDetails(with: 0) { _ in }
                // Then
                expect(environmentMock.authorizedRequestCalled).to(beTrue())
            }
            
            it("should pass request method as argument to environment authorized request function") {
                // Given
                // When
                sut.fetchEmployeeDetails(with: 0) { _ in }
                // Then
                expect(environmentMock.authorizedRequestArguments.requestMethod).to(equal(EmployeesEndpoint.FetchEmployeeDetails.method))
            }
            
            it("should pass path as argument to environment authorized request function") {
                // Given
                // When
                sut.fetchEmployeeDetails(with: 0) { _ in }
                // Then
                expect(environmentMock.authorizedRequestArguments.path).to(equal(EmployeesEndpoint.FetchEmployeeDetails.path))
            }
            
            it("should pass urlParams as argument to environment authorized request function") {
                // Given
                let id = 4
                // When
                sut.fetchEmployeeDetails(with: id) { _ in }
                // Then
                expect(environmentMock.authorizedRequestArguments.urlParams).to(equal([.employeeID: "4"]))
            }
            
            context("when success closure called") {
            
                context("when status code class is success") {
                    
                    it("should call success completion with details") {
                        // Given
                        environmentMock.authorizedRequestResult = (success: (json: [:], statusCode: 200), error: nil)
                        var fetchedEmployeeDetails: Employee.Details?
                        // When
                        sut.fetchEmployeeDetails(with: 0) { result in
                            switch result {
                            case .success(let details):
                                fetchedEmployeeDetails = details
                            case .failure(_):
                                fail("should not execute failure case")
                            }
                        }
                        // Then
                        expect(fetchedEmployeeDetails).notTo(beNil())
                    }
                }
                
                context("when status code class is client error") {
                
                    it("should call failure completion with error") {
                        // Given
                        environmentMock.authorizedRequestResult = (success: (json: [:], statusCode: 500), error: nil)
                        var fetchEmployeeDetailsError: Error?
                        // When
                        sut.fetchEmployeeDetails(with: 0) { result in
                            switch result {
                            case .success:
                                fail("should not execute success case")
                            case .failure(let error):
                                fetchEmployeeDetailsError = error
                            }
                        }
                        // Then
                        expect(fetchEmployeeDetailsError).notTo(beNil())
                    }
                }
            }
            
            context("when failure closure called") {
            
                it("should call failure completion with error") {
                    // Given
                    environmentMock.authorizedRequestResult = (success: nil, error: DummyError())
                    var fetchEmployeeDetailsError: Error?
                    // When
                    sut.fetchEmployeeDetails(with: 0) { result in
                        switch result {
                        case .success:
                            fail("should not execute success case")
                        case .failure(let error):
                            fetchEmployeeDetailsError = error
                        }
                    }
                    // Then
                    expect(fetchEmployeeDetailsError).notTo(beNil())
                }
            }
        }
        
        describe("function createEmployee") {
            
            it("should ask environment to call authorized request function") {
                // Given
                // When
                sut.createEmployee(Seeds.encodableEmployee) { _ in }
                // Then
                expect(environmentMock.authorizedRequestCalled).to(beTrue())
            }
            
            it("should pass request method as argument to environment authorized request function") {
                // Given
                // When
                sut.createEmployee(Seeds.encodableEmployee) { _ in }
                // Then
                expect(environmentMock.authorizedRequestArguments.requestMethod).to(equal(EmployeesEndpoint.CreateEmployee.method))
            }
            
            it("should pass path as argument to environment authorized request function") {
                // Given
                // When
                sut.createEmployee(Seeds.encodableEmployee) { _ in }
                // Then
                expect(environmentMock.authorizedRequestArguments.path).to(equal(EmployeesEndpoint.CreateEmployee.path))
            }
            
            it("should pass params as argument to environment authorized request function") {
                // Given
                // When
                sut.createEmployee(Seeds.encodableEmployee) { _ in }
                // Then
                expect(environmentMock.authorizedRequestArguments.params).notTo(beNil())
            }
            
            context("when success closure called") {
            
                context("when status code class is success") {
                    
                    it("should call success completion with created employee") {
                        // Given
                        environmentMock.authorizedRequestResult = (success: (json: [:], statusCode: 200), error: nil)
                        var createdEmployee: Employee?
                        // When
                        sut.createEmployee(Seeds.encodableEmployee) { result in
                            switch result {
                            case .success(let employee):
                                createdEmployee = employee
                            case .failure(_):
                                fail("should not execute failure case")
                            }
                        }
                        // Then
                        expect(createdEmployee).notTo(beNil())
                    }
                }
                
                context("when status code class is client error") {
                
                    it("should call failure completion with error") {
                        // Given
                        environmentMock.authorizedRequestResult = (success: (json: [:], statusCode: 500), error: nil)
                        var createEmployeeError: Error?
                        // When
                        sut.createEmployee(Seeds.encodableEmployee) { result in
                            switch result {
                            case .success:
                                fail("should not execute success case")
                            case .failure(let error):
                                createEmployeeError = error
                            }
                        }
                        // Then
                        expect(createEmployeeError).notTo(beNil())
                    }
                }
            }
            
            context("when failure closure called") {
            
                it("should call failure completion with error") {
                    // Given
                    environmentMock.authorizedRequestResult = (success: nil, error: DummyError())
                    var createEmployeeError: Error?
                    // When
                    sut.createEmployee(Seeds.encodableEmployee) { result in
                        switch result {
                        case .success:
                            fail("should not execute success case")
                        case .failure(let error):
                            createEmployeeError = error
                        }
                    }
                    // Then
                    expect(createEmployeeError).notTo(beNil())
                }
            }
        }
    }
}
