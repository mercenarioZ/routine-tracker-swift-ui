//
//  MainTabView.swift
//  RoutineTracker
//
//  Created by Le Ba Nguyen Vu on 11/2/26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Routine Create", systemImage: "plus.circle")
                }

            TaskListView()
                .tabItem {
                    Label("Task List", systemImage: "checklist")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(AppColors.primaryGreen)
    }
}
