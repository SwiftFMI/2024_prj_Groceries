//
//  FirebaseAuth.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import FirebaseAuth



final class FirebaseAuth {
    private let auth = Auth.auth()
        
    func isLoggedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
             if let error = error {
                 completion(.failure(error))
                 return
             }
             DispatchQueue.main.async {
                 completion(.success(()))
             }
         }
    }
    
    func register(email: String, password: String,
                      completion: @escaping (Result<Void, Error>) -> Void) {

            auth.createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                DispatchQueue.main.async {
                    completion(.success(()))
                }
            }
        }
        
}
                                              
