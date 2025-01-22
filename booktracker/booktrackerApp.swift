//
//  booktrackerApp.swift
//  booktracker
//
//  Created by Alex Hernández on 13/1/25.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct booktrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView(shouldShowOnboarding: $isOnboarding)
            } else {
                PreLoginView(shouldShowOnboarding: $isOnboarding)
            }
            
        }
        
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        GIDSignIn.sharedInstance.signOut()
        
        return true
    }
}

