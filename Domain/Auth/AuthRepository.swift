//
//  AuthRepository.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

protocol AuthRepository {
    func login(email: String, password: String) async throws
}
