//
//  SessionManager.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import Foundation
import Combine

@MainActor
final class SessionManager: ObservableObject {
    @Published private(set) var isLoggedIn: Bool = false
    @Published private(set) var currentUser: UserProfile?

    private let tokenStore: TokenStore

    init(tokenStore: TokenStore? = nil) {
        self.tokenStore = tokenStore ?? KeychainTokenStore()
        bootstrap()
    }

    private func bootstrap() {
        isLoggedIn = tokenStore.loadAccessToken() != nil
        currentUser = isLoggedIn ? SessionMockData.currentUser : nil
    }

    func onLoginSuccess() {
        isLoggedIn = true
        currentUser = SessionMockData.currentUser
    }

    func logout() {
        try? tokenStore.clear()
        isLoggedIn = false
        currentUser = nil
    }
}
