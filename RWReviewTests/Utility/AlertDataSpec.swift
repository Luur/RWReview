//
//  AlertDataSpec.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RWReview

class AlertDataSpec: QuickSpec {
    
    override func spec() {

        // MARK: - Subject under test
    
        var sut: AlertData!
    
        // MARK: - Tests
        
        describe("initialization") {
        
            it("should be able to initialize correctly") {
                // Given
                let title = "alert_title"
                let message = "alertMessage"
                // When
                sut = AlertData(title: title, message: message)
                // Then
                expect(sut).notTo(beNil())
                expect(sut.title).to(equal(title))
                expect(sut.message).to(equal(message))
            }
        }
    }
}
