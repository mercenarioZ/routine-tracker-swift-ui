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
        VStack(spacing: 16) {
            Text("Home")
                .font(.title.bold())
            Button("Logout") {
                session.logout()
            }
            .buttonStyle(.bordered)
        }
        .padding(20)
    }
}
