//
//  LoginView.swift
//  KiwiSocial
//
//  Created by Daniel Visage on 13/04/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false
    @ObservedObject var authViewModel = AuthViewModel()

    var body: some View {
        NavigationStack(){
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }

                Button(action: {
                    authViewModel.signIn(email: email, password: password) { result in
                        switch result {
                        case .success:
                            errorMessage = ""
                            print("Signed in!")
                            isLoggedIn = true
                        case .failure(let error):
                            errorMessage = error.localizedDescription
                        }
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .navigationDestination(isPresented: $isLoggedIn) {
                             HomeView()
                         }
            }
            .padding()
        }
   
    }
}

