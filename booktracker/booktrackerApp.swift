//
//  booktrackerApp.swift
//  booktracker
//
//  Created by Alex Hernández on 13/1/25.
//

import SwiftUI

@main
struct booktrackerApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView(shouldShowOnboarding: $isOnboarding)
            } else {
                LoginView()
            }
        }
    }
}
