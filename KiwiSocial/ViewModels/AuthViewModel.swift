//
//  AuthViewModel.swift
//  KiwiSocial
//
//  Created by Daniel Visage on 13/04/2025.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    func getCurrentUserEmail() -> String? {
        return Auth.auth().currentUser?.email
    }
}
