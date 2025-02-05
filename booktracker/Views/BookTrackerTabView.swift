//
//  BookTrackerTabView.swift
//  booktracker
//
//  Created by Alex Hernández on 13/1/25.
//

import SwiftUI

struct BookTrackerTabView: View {
    
    @ObservedObject var authViewModel: AuthenticationViewModel

    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("Listado", systemImage: "list.triangle")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "text.page.badge.magnifyingglass")
                }
            
            SettingsView(authViewModel: authViewModel)
                .tabItem {
                    Label("Opciones", systemImage: "gear")
                }
        }
        .tint(.purple)
    }
}

#Preview {
    BookTrackerTabView(authViewModel: AuthenticationViewModel())
}
