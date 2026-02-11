//
//  LoginView.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var session: SessionManager
    @StateObject private var vm = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "leaf.circle.fill")
                .font(.system(size: 100))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            AppColors.leafGradientStart,
                            AppColors.leafGradientEnd
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding(.top, 8)

            Text("Welcome to Routine")
                .font(.largeTitle.bold())
                .padding(.bottom, 10)

            Text("Login")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)

            Text("Demo account: demo@routine.app / 123456")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("Email", text: $vm.email)
                .loginEmailInputStyle()
                .padding(.horizontal, 14)
                .frame(height: 48)
                .loginFieldBackground()

            SecureField("Password", text: $vm.password)
                .padding(.horizontal, 14)
                .frame(height: 48)
                .loginFieldBackground()

            if let errorMessage = vm.errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Button {
                Task {
                    let success = await vm.login()
                    if success {
                        session.onLoginSuccess()
                    }
                }
            } label: {
                if vm.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Sign In")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 48)
            .buttonStyle(.borderedProminent)
            .disabled(!vm.canSubmit)
            .opacity(vm.canSubmit ? 1 : 0.7)
        }
        .padding(20)
    }
}

private extension View {
    @ViewBuilder
    func loginEmailInputStyle() -> some View {
        #if canImport(UIKit)
        self
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .keyboardType(.emailAddress)
        #else
        self
        #endif
    }

    @ViewBuilder
    func loginFieldBackground() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(AppColors.inputSurface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(AppColors.accentGreen.opacity(0.55), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.02), radius: 4, x: 0, y: 2)
    }
}
