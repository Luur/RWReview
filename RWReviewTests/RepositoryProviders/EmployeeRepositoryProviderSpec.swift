//
//  EmployeeRepositoryProviderSpec.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RWReview

class EmployeesRepositoryProviderSpec: QuickSpec {

    override func spec() {

        // MARK: - Subject under test

        var sut: EmployeesRepositoryProvider!

        // MARK: - Test setup

        beforeEach {
            sut = EmployeesRepositoryProvider()
        }

        // MARK: - Tests
    
        describe("function getEmployeesRepository") {
            
            context("when current environment type is mock") {
                
                it("should return employees memory repository") {
                    UserDefaults.blankDefaultsWhile {
                        // Given
                        Environment.saveEnvironment(name: "Mock")
                        // When
                        let result = sut.getEmployeesRepository()
                        // Then
                        expect(result).to(beAnInstanceOf(EmployeesMemoryRepository.self))
                    }
                }
            }
            
            context("when current environment type is REST") {
                
                it("should return employees web repository") {
                    UserDefaults.blankDefaultsWhile {
                        // Given
                        Environment.saveEnvironment(name: "Development")
                        // When
                        let result = sut.getEmployeesRepository()
                        // Then
                        expect(result).to(beAnInstanceOf(EmployeesWebRepository.self))
                    }
                }
            }
        }
    }
}
