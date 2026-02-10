//
//  LoginViewModel.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let authUseCase: AuthUseCase
    
    init(authUseCase: AuthUseCase? = nil) {
        self.authUseCase = authUseCase ?? DefaultAuthUseCase()
    }
    
    var canSubmit: Bool {
        !isLoading
            && !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !password.isEmpty
    }

    func login() async -> Bool {
        errorMessage = nil
       
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await authUseCase.login(
                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                password: password
            )
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
