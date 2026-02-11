//
//  ContentView.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 10/2/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            Group {
                if session.isLoggedIn {
                    MainTabView()
                } else {
                    LoginView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionManager())
    }
}

enum AppColors {
    static let background = Color(red: 0.92, green: 0.98, blue: 0.92)
    static let primaryGreen = Color(red: 0.22, green: 0.50, blue: 0.24)
    static let accentGreen = Color(red: 0.55, green: 0.75, blue: 0.55)
    static let leafGradientStart = Color(red: 0.30, green: 0.70, blue: 0.34)
    static let leafGradientEnd = Color(red: 0.56, green: 0.83, blue: 0.48)

    static let surfaceStrong = Color.white.opacity(0.9)
    static let surfaceSoft = Color.white.opacity(0.86)
    static let inputSurface = Color.white.opacity(0.8)
}
