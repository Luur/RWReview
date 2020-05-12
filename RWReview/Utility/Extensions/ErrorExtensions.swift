//
//  ErrorExtensions.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation

extension Error {
    var urlErrorCode: URLError.Code? {
        let urlError = self as? URLError
        return urlError?.code
    }
}
