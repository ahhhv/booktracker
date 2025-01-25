//
//  LoginView.swift
//  booktracker
//
//  Created by Alex Hernández on 13/1/25.
//

import SwiftUI

struct LoginView: View {
    @Binding var shouldShowOnboarding: Bool
    @State private var err: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.orange, Color.red]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {
                VStack(spacing: 10) {
                    Image(systemName: "book.pages")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .foregroundColor(.black)
                    Text("Book Tracker")
                        .font(.system(size: 75))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                   
                    Text("Te ayudamos a trackear tus libros favoritos")
                        .foregroundColor(.black)
                }
                .multilineTextAlignment(.center)
                
                Button {
                    Task {
                        do {
                            try await AuthenticationService().googleOauth()
                        } catch AuthenticationError.runtimeError(let errorMessage) {
                            err = errorMessage
                        }
                    }
                } label: {
                    Text("Iniciar sesión con Google")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(50)
                
                Spacer()
                
                Button {
                    shouldShowOnboarding = true
                } label: {
                    Text("Volver a ver el tutorial")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        .font(.callout)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}

#Preview {
    LoginView(shouldShowOnboarding: .constant(true))
}
