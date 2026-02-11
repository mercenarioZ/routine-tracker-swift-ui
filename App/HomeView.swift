//
//  HomeView.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var session: SessionManager
    @State private var isShowingProfile = false

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
                    isShowingProfile = true
                } label: {
                    if let user = session.currentUser {
                        Text(user.initials)
                            .font(.system(size: 14, weight: .bold))
                            .frame(width: 42, height: 42)
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 22))
                            .frame(width: 42, height: 42)
                    }
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
                .sheet(isPresented: $isShowingProfile) {
                    profileSheet
                        .presentationDetents([.medium])
                }

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

    private var profileSheet: some View {
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 24)
        .background(AppColors.background)
    }
}
