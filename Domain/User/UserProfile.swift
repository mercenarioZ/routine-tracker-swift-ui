//
//  UserProfile.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 11/2/26.
//

import Foundation

struct UserProfile {
    let id: UUID
    let fullName: String
    let email: String

    var initials: String {
        let parts = fullName
            .split(separator: " ")
            .prefix(2)
            .compactMap { $0.first }

        let value = String(parts)
        return value.isEmpty ? "U" : value.uppercased()
    }
}
