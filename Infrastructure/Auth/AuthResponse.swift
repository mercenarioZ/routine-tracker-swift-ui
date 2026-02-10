//
//  AuthResponse.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

struct AuthResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
