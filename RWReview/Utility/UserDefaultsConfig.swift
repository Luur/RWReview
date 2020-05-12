//
//  UserDefaultsConfig.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    private let key: String
    private let defaultValue: T
    private let userDefaults: UserDefaults

    init(_ key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    var wrappedValue: T {
        get {
             guard let value = userDefaults.object(forKey: key) else {
                return defaultValue
            }
            return value as? T ?? defaultValue
        }
        set {
            if let value = newValue as? OptionalProtocol, value.isNil() {
                userDefaults.removeObject(forKey: key)
            } else {
                userDefaults.set(newValue, forKey: key)
            }
        }
    }
}

fileprivate protocol OptionalProtocol {
    func isNil() -> Bool
}

extension Optional : OptionalProtocol {
    func isNil() -> Bool {
        return self == nil
    }
}

struct UserDefaultsConfig {
    
    @UserDefault("environment", defaultValue: nil)
    static var environment: String?
    
    @UserDefault("access_token", defaultValue: nil)
    static var token: String?
}
