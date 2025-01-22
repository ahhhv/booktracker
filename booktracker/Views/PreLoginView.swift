//
//  PreLoginView.swift
//  booktracker
//
//  Created by Alex Hernández on 16/1/25.
//

import SwiftUI
import FirebaseAuth

struct PreLoginView: View {
    @State private var userLoggedIn = Auth.auth().currentUser != nil
    @Binding var shouldShowOnboarding: Bool

    var body: some View {
        ZStack {
            if userLoggedIn {
                BookTrackerTabView()
            } else {
                LoginView(shouldShowOnboarding: $shouldShowOnboarding)
            }
        }
        .onAppear {
            _ = Auth.auth().addStateDidChangeListener { auth, user in
                if (user != nil) {
                    userLoggedIn = true
                } else {
                    userLoggedIn = false
                }
            }
        }
    }
}

#Preview {
    PreLoginView(shouldShowOnboarding: .constant(true))
}
