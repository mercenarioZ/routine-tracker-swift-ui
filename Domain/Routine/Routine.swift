//
//  Routine.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 11/2/26.
//

import Foundation

enum RoutineFrequency: String, CaseIterable, Identifiable {
    case daily = "DAILY"
    case weekly = "WEEKLY"
    case custom = "CUSTOM"

    var id: String { rawValue }
}

struct Routine: Identifiable {
    let id: UUID
    let userId: UUID
    let title: String
    let description: String?
    let frequency: RoutineFrequency
    let startDate: Date?
    let isActive: Bool
    let createdAt: Date

    init(
        id: UUID = UUID(),
        userId: UUID,
        title: String,
        description: String?,
        frequency: RoutineFrequency,
        startDate: Date?,
        isActive: Bool,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.title = title
        self.description = description
        self.frequency = frequency
        self.startDate = startDate
        self.isActive = isActive
        self.createdAt = createdAt
    }
}
