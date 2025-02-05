//
//  RootView.swift
//  booktracker
//
//  Created by Grace Toa on 28/1/25.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {
    
    @StateObject var authViewModel =  AuthenticationViewModel()
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @State private var isCheckingSession = true

    var body: some View {
        Group {
            if isCheckingSession {
                ProgressView("Verificando sesión...")
            } else {
                if isOnboarding {
                    OnboardingView(shouldShowOnboarding: $isOnboarding)
                } else {
                    PreLoginView(authViewModel: authViewModel, shouldShowOnboarding: $isOnboarding)
                }
            }
        }
        .onAppear {
            checkSession()
        }
    }

    func checkSession() {
        if Auth.auth().currentUser != nil {
            authViewModel.isAuthenticated = true
        } else {
            authViewModel.isAuthenticated = false
        }
        isCheckingSession = false
    }
}
