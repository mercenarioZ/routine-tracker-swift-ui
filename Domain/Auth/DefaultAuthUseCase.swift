//
//  DefaultAuthUseCase.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

final class DefaultAuthUseCase: AuthUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository = DefaultAuthRepository()) {
        self.repository = repository
    }
    
    func login(email: String, password: String) async throws {
        try await repository.login(email: email, password: password)
    }
}
