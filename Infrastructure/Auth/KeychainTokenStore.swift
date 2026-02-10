//
//  KeychainTokenStore.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import Foundation
import Security

final class KeychainTokenStore: TokenStore {
    func save(accessToken: String, refreshToken: String) throws {
        save(key: "access_token", value: accessToken)
        save(key: "refresh_token", value: refreshToken)
    }
    
    private func save(key: String, value: String) {
        let data = value.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
}
