//
//  SettingsView.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 11/2/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        VStack(spacing: 16) {
            Text("Settings")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 12) {
                Circle()
                    .fill(AppColors.surfaceStrong)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text(session.currentUser?.initials ?? "U")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(AppColors.primaryGreen)
                    )
                    .overlay(
                        Circle()
                            .stroke(AppColors.accentGreen.opacity(0.45), lineWidth: 1)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(session.currentUser?.fullName ?? "Unknown user")
                        .font(.subheadline.weight(.semibold))
                    Text(session.currentUser?.email ?? "-")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(AppColors.surfaceSoft)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(AppColors.accentGreen.opacity(0.35), lineWidth: 1)
            )

            Button {
                session.logout()
            } label: {
                Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
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

            Spacer()
        }
        .padding(20)
    }
}
