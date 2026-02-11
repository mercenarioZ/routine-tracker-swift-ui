//
//  SessionMockData.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 11/2/26.
//

import Foundation

enum SessionMockData {
    static let currentUser = UserProfile(
        id: UUID(uuidString: "4E0890F6-2EAF-43E6-A643-B3B3F0F1E0B9") ?? UUID(),
        fullName: "Le Ba Nguyen Vu",
        email: "demo@routine.app"
    )
}
