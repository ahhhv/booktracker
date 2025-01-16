//
//  BookTrackerTabView.swift
//  booktracker
//
//  Created by Alex Hernández on 13/1/25.
//

import SwiftUI

struct BookTrackerTabView: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("Listado", systemImage: "list.triangle")
                }

            SearchView()
                .tabItem {
                    Label("Buscar", systemImage: "text.page.badge.magnifyingglass")
                }
            
            SettingsView()
                .tabItem {
                    Label("Opciones", systemImage: "gear")
                }
        }
        .tint(.purple)
    }
}

#Preview {
    BookTrackerTabView()
}
