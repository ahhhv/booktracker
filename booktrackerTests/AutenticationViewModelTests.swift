//
//  AutenticationViewModelTests.swift
//  booktrackerTests
//
//  Created by Grace Toa on 24/1/25.
//

import XCTest
@testable import booktracker

@MainActor
final class AuthenticationViewModelTests: XCTestCase {
    
    func testGoogleLoginSuccess() async throws {
        
        let mockService = MockAuthentication()
        mockService.shouldSucceed = true
        let viewModel = AuthenticationViewModel(authenticationService: mockService)

        await viewModel.loginWithGoogle()

        XCTAssertTrue(mockService.didCallGoogleOauth, "googleOauth() should be called")
        XCTAssertTrue(viewModel.isAuthenticated, "User should be authenticated")
        XCTAssertNil(viewModel.errorMessage, "Error message shoul be nil")
    }

    func testGoogleLoginFailure() async throws {
        
        let mockService = MockAuthentication()
        mockService.shouldSucceed = false
        let viewModel = AuthenticationViewModel(authenticationService: mockService)

        await viewModel.loginWithGoogle()

        XCTAssertTrue(mockService.didCallGoogleOauth, "googleOauth() should be called")
        XCTAssertFalse(viewModel.isAuthenticated, "User should not be authenticated")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set")
    }

    func testLogoutSuccess() async throws {
        
        let mockService = MockAuthentication()
        mockService.shouldSucceed = true
        let viewModel = AuthenticationViewModel(authenticationService: mockService)

        await viewModel.logout()

        XCTAssertTrue(mockService.didCallLogout, "logout() should be called")
        XCTAssertFalse(viewModel.isAuthenticated, "User should be logged out")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil")
    }

    func testLogoutFailure() async throws {
        
        let mockService = MockAuthentication()
        mockService.shouldSucceed = false
        let viewModel = AuthenticationViewModel(authenticationService: mockService)

        await viewModel.logout()

        XCTAssertTrue(mockService.didCallLogout, "logout() should be called")
        XCTAssertTrue(viewModel.isAuthenticated, "User should be authenticated if the logout failed")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set")
    }
}
