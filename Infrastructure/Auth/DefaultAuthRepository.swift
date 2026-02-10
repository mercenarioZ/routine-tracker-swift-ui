//
//  DefaultAuthRepository.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

final class DefaultAuthRepository: AuthRepository {
    private let api = AuthAPI()
    private let tokenStore: TokenStore = KeychainTokenStore()

    func login(email: String, password: String) async throws {
        let response = try await api.login(email: email, password: password)
        try tokenStore.save(
            accessToken: response.accessToken,
            refreshToken: response.refreshToken
        )
    }
}

