//
//  UserDefaults.swift
//  Month5-1
//
//  Created by Sonun on 31/5/23.
//

import Foundation

class UserDefault {
    
    enum Keys: String {
        case userSession, saveLogin
    }
    
    static let shared = UserDefault()
    private let userDefaults = UserDefaults.standard
    
    private init() { }
    
    func save <T: Any>(_ data: T, forkey key: Keys) {
        userDefaults.set(data, forKey: key.rawValue)
    }
    
    func getBool(forkey key: Keys) -> Bool {
        userDefaults.bool(forKey: key.rawValue)
    }
}
