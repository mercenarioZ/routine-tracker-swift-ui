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
            Text("Login")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("Email", text: $vm.email)
                .loginEmailInputStyle()
                .padding(.horizontal, 14)
                .frame(height: 48)
                .loginFieldBackground()
                .clipShape(RoundedRectangle(cornerRadius: 12))

            SecureField("Password", text: $vm.password)
                .padding(.horizontal, 14)
                .frame(height: 48)
                .loginFieldBackground()
                .clipShape(RoundedRectangle(cornerRadius: 12))

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
        #if canImport(UIKit)
        self.background(Color(uiColor: .secondarySystemBackground))
        #else
        self.background(Color.gray.opacity(0.12))
        #endif
    }
}
