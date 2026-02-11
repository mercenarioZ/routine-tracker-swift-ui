//
//  ProfileView.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 11/2/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        VStack(spacing: 16) {
            Circle()
                .fill(AppColors.surfaceStrong)
                .frame(width: 100, height: 100)
                .overlay(
                    Text(session.currentUser?.initials ?? "U")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(AppColors.primaryGreen)
                )
                .overlay(
                    Circle()
                        .stroke(AppColors.accentGreen.opacity(0.45), lineWidth: 1)
                )

            Text(session.currentUser?.fullName ?? "Unknown user")
                .font(.title3.bold())

            Text(session.currentUser?.email ?? "-")
                .font(.subheadline)
                .foregroundStyle(.secondary)

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
            .padding(.top, 12)

            Spacer()
        }
        .padding(20)
    }
}
