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
    @Published private(set) var routines: [Routine] = []

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
        routines = []
    }

    func logout() {
        try? tokenStore.clear()
        isLoggedIn = false
        currentUser = nil
        routines = []
    }

    func createRoutine(
        title: String,
        description: String?,
        frequency: RoutineFrequency,
        startDate: Date?,
        isActive: Bool
    ) {
        guard let userId = currentUser?.id else { return }

        let normalizedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !normalizedTitle.isEmpty else { return }

        let normalizedDescription = description?
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let safeDescription = normalizedDescription?.isEmpty == true ? nil : normalizedDescription

        let routine = Routine(
            userId: userId,
            title: normalizedTitle,
            description: safeDescription,
            frequency: frequency,
            startDate: startDate,
            isActive: isActive
        )
        routines.insert(routine, at: 0)
    }
}
