//
//  AuthenticationViewModel.swift
//  booktracker
//
//  Created by Grace Toa on 24/1/25.
//
import SwiftUI
import FirebaseAuth

@MainActor
final class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?

    private let authenticationService: AuthenticationServiceProtocol

    init(authenticationService: AuthenticationServiceProtocol = AuthenticationService()) {
        self.authenticationService = authenticationService
        self.isAuthenticated = Auth.auth().currentUser != nil
    }

    func loginWithGoogle() async {
        do {
            try await authenticationService.googleOauth()
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
            isAuthenticated = false
        }
    }

    func logout() async {
        do {
            try await authenticationService.logout()
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
            isAuthenticated = true
        }
    }
}
