//
//  HomeView.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Home")
                        .font(.largeTitle.bold())
                    Text("Track your routines consistently")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button {
                } label: {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 22))
                        .frame(width: 42, height: 42)
                }
                .foregroundStyle(AppColors.primaryGreen)
                .background(
                    Circle()
                        .fill(AppColors.surfaceStrong)
                )
                .overlay(
                    Circle()
                        .stroke(AppColors.accentGreen.opacity(0.5), lineWidth: 1)
                )
                .accessibilityLabel("Profile")

                Button {
                    session.logout()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 42, height: 42)
                }
                .foregroundStyle(AppColors.primaryGreen)
                .background(
                    Circle()
                        .fill(AppColors.surfaceStrong)
                )
                .overlay(
                    Circle()
                        .stroke(AppColors.accentGreen.opacity(0.5), lineWidth: 1)
                )
                .accessibilityLabel("Logout")
            }

            VStack(alignment: .leading, spacing: 10) {
                Label("Today", systemImage: "calendar")
                    .font(.headline)
                Text("No routines yet. Start by adding your first routine.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
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
