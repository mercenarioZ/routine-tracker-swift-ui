//
//  AuthUseCase.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

protocol AuthUseCase {
    func login(email: String, password: String) async throws
}
