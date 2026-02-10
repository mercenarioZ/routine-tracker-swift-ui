//
//  AuthAPI.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import Foundation

enum AuthError: LocalizedError {
    case invalidCredential
    case keychainOperationFailed

    var errorDescription: String? {
        switch self {
        case .invalidCredential:
            return "Email or password is incorrect."
        case .keychainOperationFailed:
            return "Unable to store authentication token."
        }
    }
}

struct AuthAPI {
    func login(email: String, password: String) async throws -> AuthResponse {
        let url = URL(string: "http://localhost:8080/v1/api/auth/login")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw AuthError.invalidCredential
        }
        
        return try JSONDecoder().decode(AuthResponse.self, from: data)
    }
}
