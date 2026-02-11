//
//  HomeView.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var session: SessionManager
    @State private var newRoutineTitle = ""
    @State private var newRoutineDescription = ""
    @State private var selectedFrequency: RoutineFrequency = .daily
    @State private var includeStartDate = false
    @State private var selectedStartDate = Date()
    @State private var isRoutineActive = true

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Home")
                            .font(.largeTitle.bold())
                        Text("Track your routines consistently")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 12) {
                    Label("Create routine", systemImage: "plus.circle")
                        .font(.headline)

                    TextField("Routine title", text: $newRoutineTitle)
                        .routineInputFieldStyle()

                    TextField("Description (optional)", text: $newRoutineDescription)
                        .routineInputFieldStyle()

                    Picker("Frequency", selection: $selectedFrequency) {
                        ForEach(RoutineFrequency.allCases) { frequency in
                            Text(frequency.rawValue).tag(frequency)
                        }
                    }
                    .pickerStyle(.segmented)

                    Toggle("Include start date", isOn: $includeStartDate)
                        .tint(AppColors.primaryGreen)

                    if includeStartDate {
                        DatePicker(
                            "Start date",
                            selection: $selectedStartDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                    }

                    Toggle("Active", isOn: $isRoutineActive)
                        .tint(AppColors.primaryGreen)

                    Button {
                        session.createRoutine(
                            title: newRoutineTitle,
                            description: newRoutineDescription,
                            frequency: selectedFrequency,
                            startDate: includeStartDate ? selectedStartDate : nil,
                            isActive: isRoutineActive
                        )
                        newRoutineTitle = ""
                        newRoutineDescription = ""
                        selectedFrequency = .daily
                        includeStartDate = false
                        selectedStartDate = Date()
                        isRoutineActive = true
                    } label: {
                        Label("Create Routine", systemImage: "plus")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 42)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(AppColors.primaryGreen)
                    )
                    .disabled(newRoutineTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(newRoutineTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.55 : 1)

                    if session.routines.isEmpty {
                        Text("No routines yet. Start by adding your first routine.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(session.routines) { routine in
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack(spacing: 8) {
                                        Image(systemName: routine.isActive ? "checkmark.circle.fill" : "pause.circle")
                                            .foregroundStyle(AppColors.primaryGreen)
                                        Text(routine.title)
                                            .font(.subheadline.weight(.semibold))
                                    }

                                    Text("Frequency: \(routine.frequency.rawValue)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)

                                    if let description = routine.description {
                                        Text(description)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }

                                    if let startDate = routine.startDate {
                                        Text("Start: \(startDate.formatted(date: .abbreviated, time: .omitted))")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.vertical, 6)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .overlay(alignment: .bottom) {
                                    Divider()
                                        .foregroundStyle(AppColors.primaryGreen)
                                        .padding(.top, 4)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(AppColors.surfaceSoft)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(AppColors.accentGreen.opacity(0.55), lineWidth: 1)
                )

                Spacer()
            }
            .padding(20)
        }
        
    }
}

private extension View {
    func routineInputFieldStyle() -> some View {
        self
            .padding(.horizontal, 12)
            .frame(height: 42)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(AppColors.inputSurface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(AppColors.accentGreen.opacity(0.45), lineWidth: 1)
            )
    }
}
