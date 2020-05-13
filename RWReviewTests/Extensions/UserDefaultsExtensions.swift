//
//  UserDefaultsExtensions.swift
//  RWReviewTests
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static func blankDefaultsWhile(handler: () -> Void) {
        guard let name = Bundle.main.bundleIdentifier else {
            fatalError("Couldn't find bundle ID.")
        }
        let old = UserDefaults.standard.persistentDomain(forName: name)
        defer {
            UserDefaults.standard.setPersistentDomain( old ?? [:], forName: name)
        }
        UserDefaults.standard.removePersistentDomain(forName: name)
        handler()
    }
}
