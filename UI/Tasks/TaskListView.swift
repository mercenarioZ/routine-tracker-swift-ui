//
//  TaskListView.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 11/2/26.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        VStack(spacing: 16) {
            Text("Task List")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Tasks will be generated from routines.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if session.routines.isEmpty {
                Text("No tasks yet because no routines are created.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(session.routines) { routine in
                            HStack(spacing: 10) {
                                Image(systemName: "checklist")
                                    .foregroundStyle(AppColors.primaryGreen)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(routine.title)
                                        .font(.subheadline.weight(.semibold))
                                    Text("From \(routine.frequency.rawValue) routine")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(AppColors.surfaceSoft)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(AppColors.accentGreen.opacity(0.35), lineWidth: 1)
                            )
                        }
                    }
                }
            }

            Spacer()
        }
        .padding(20)
    }
}
