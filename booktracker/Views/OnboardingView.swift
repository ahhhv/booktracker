//
//  OnboardingView.swift
//  booktracker
//
//  Created by Alex Hernández on 13/1/25.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var shouldShowOnboarding: Bool

    var body: some View {
        TabView {
            PageView(
                title: "¡Bienvenido a Book Tracker!",
                subtitle: "La app que te mantendrá al día de tus estrenos literarios",
                imageName: "book",
                showDismissButton: false,
                shouldShowOnboarding: $shouldShowOnboarding)

            PageView(
                title: "Notificaciones push",
                subtitle: "¡Habilita las notificaciones para estar al tanto de cuándo salen tus libros favoritos!",
                imageName: "bell.and.waves.left.and.right.fill",
                showDismissButton: false,
                shouldShowOnboarding: $shouldShowOnboarding)

            PageView(
                title: "Favoritos",
                subtitle: "Añade a favoritos los libros que más ansíes",
                imageName: "heart.fill",
                showDismissButton: true,
                shouldShowOnboarding: $shouldShowOnboarding)
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .systemBlue
            UIPageControl.appearance().pageIndicatorTintColor = .green
        }
    }
}

struct PageView: View {

    let title: String
    let subtitle: String
    let imageName: String
    let showDismissButton: Bool
    @Binding var shouldShowOnboarding: Bool

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding()

            Text(title)
                .font(.system(size: 24))
                .padding()

            Text(subtitle)
                .fontWeight(.regular)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()

            if showDismissButton {
                Button {
                    shouldShowOnboarding.toggle()
                } label: {
                    Text("¿Empezamos?")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(.green)
                        .cornerRadius(6)
                }
            }
        }
    }
}

#Preview {
    OnboardingView(shouldShowOnboarding: .constant(true))
}
