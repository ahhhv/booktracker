//
//  LoginView.swift
//  booktracker
//
//  Created by Alex Hernández on 13/1/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.yellow, Color.red]),
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
                            // do stuff
                        } catch {
                            print("Error signing in with Apple: \(error)")
                        }
                    }
                } label: {
                    Image("dark-google-icon")
                        .resizable()
                        .frame(width: 65, height: 65)
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    LoginView()
}
