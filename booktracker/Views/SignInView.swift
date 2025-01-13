//
//  SignIn.swift
//  booktracker
//
//  Created by Grace Toa on 13/1/25.
//


import SwiftUI

struct SignIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack(spacing: 30) {
            VStack {
                Image(systemName: "book.pages")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.black)
                
                Text("Welcome ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Text("to Book Tracker")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray.opacity(0.8))
                    .padding(.horizontal, 30)
            }
            VStack(spacing: 20) {
                TextField("Email Address", text: $email)
                    .padding()
                    .background(Color.orange.opacity(0.04))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.orange.opacity(0.04))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
                Button(action: {
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                
                HStack {
                    Button(action: {
                        // Forgot Password action
                    }) {
                        Text("Forgot Password")
                            .font(.footnote)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    
                    Text("|").font(.footnote).foregroundColor(.gray.opacity(0.7))
                    
                    Button(action: {
                        // Register action
                    }) {
                        Text("Register")
                            .font(.footnote)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                }
                .padding(.top, 10)
            }
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            
        }
        .padding(.top,-100)
    }
}

#Preview {
    SignIn()
}

