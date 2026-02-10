//
//  LoginViewModel.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: bool = false
    @Published var errorMessage: String?
    
    private let authUseCase: AuthUseCase
    
    init (authUseCase: AuthUseCase = DefaultAuthUseCase()) {
        self.authUseCase = authUseCase
    }
    
    func login() async {
        errorMessage = nil
       
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await authUseCase.login(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
