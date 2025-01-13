//
//  SignUpView.swift
//  booktracker
//
//  Created by Grace Toa on 13/1/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "book.pages")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.black)
                
                Text("Sign up ")
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
                
                Button(action: {
                    // Add photo action
                }) {
                    Circle()
                        .strokeBorder(Color.orange.opacity(0.7), lineWidth: 1.5)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Text("Add\nPhoto")
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        )
                }
                .padding(.top, 10)
                
                VStack(spacing: 15) {
                    TextField("Name and Surname", text: $name)
                        .padding()
                        .background(Color.orange.opacity(0.04))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color.orange.opacity(0.04))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .keyboardType(.emailAddress)
                    
                    TextField("Phone", text: $phone)
                        .padding()
                        .background(Color.orange.opacity(0.04))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .keyboardType(.phonePad)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.orange.opacity(0.04))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    // Register action
                }) {
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
        }
        .padding(.top,25)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
