//
//  DefaultAuthRepository.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import Foundation

final class DefaultAuthRepository: AuthRepository {
    enum Mode {
        case mock
        case live
    }

    private let api: AuthAPI
    private let tokenStore: TokenStore
    private let mode: Mode

    init(
        mode: Mode = .mock,
        api: AuthAPI = AuthAPI(),
        tokenStore: TokenStore? = nil
    ) {
        self.mode = mode
        self.api = api
        self.tokenStore = tokenStore ?? KeychainTokenStore()
    }

    func login(email: String, password: String) async throws {
        let response: AuthResponse

        switch mode {
        case .mock:
            response = try mockLogin(email: email, password: password)
        case .live:
            response = try await api.login(email: email, password: password)
        }

        try tokenStore.save(
            accessToken: response.accessToken,
            refreshToken: response.refreshToken
        )
    }

    private func mockLogin(email: String, password: String) throws -> AuthResponse {
        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        let isValidUser = normalizedEmail == "demo@routine.app" && password == "123456"

        guard isValidUser else {
            throw AuthError.invalidCredential
        }

        return AuthResponse(
            accessToken: "mock_access_token",
            refreshToken: "mock_refresh_token"
        )
    }
}
