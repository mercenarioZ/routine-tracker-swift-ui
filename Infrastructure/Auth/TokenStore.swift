//
//  Untitled.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

protocol TokenStore {
    func save(accessToken: String, refreshToken: String) throws
}
