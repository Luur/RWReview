//
//  HTTPErrors.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation

struct HTTPErrors {
    
    // 422
    struct UnprocessableEntity: Codable {
        var errors: Errors
        
        init(message: String?) {
            self.errors = Errors(message: message)
        }
        
        struct Errors: Codable {
            var error: [String] = []
            
            init(message: String?) {
                message.map {
                    self.error = [$0]
                }
            }
        }
    }
    
    // 400
    struct BadRequest: Codable {
        var errors: [Error]
        
        init(message: String) {
            self.errors = [Error(message: message)]
        }
        
        struct Error: Codable {
            var detail: String
            
            init(message: String) {
                self.detail = message
            }
        }
    }
}
