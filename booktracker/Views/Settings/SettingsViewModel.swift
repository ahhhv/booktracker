//
//  SettingsViewModel.swift
//  booktracker
//
//  Created by Alex Hernández on 5/2/25.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("notificationsActivated") var notificationsActivated = false
}
