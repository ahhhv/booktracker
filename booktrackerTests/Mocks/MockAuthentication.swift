//
//  MockAuthentication.swift
//  booktracker
//
//  Created by Grace Toa on 24/1/25.
//

import Foundation
@testable import booktracker

class MockAuthentication: AuthenticationServiceProtocol {
    var shouldSucceed: Bool = true
    var didCallGoogleOauth = false
    var didCallLogout = false

    @MainActor
    func googleOauth() async throws {
        didCallGoogleOauth = true
        if !shouldSucceed {
            throw AuthenticationError.runtimeError("Ha fallado la autenticación")
        }
    }

    func logout() async throws {
        didCallLogout = true
        if !shouldSucceed {
            throw AuthenticationError.runtimeError("Ha fallado el cierre de sesión")
        }
    }
}
