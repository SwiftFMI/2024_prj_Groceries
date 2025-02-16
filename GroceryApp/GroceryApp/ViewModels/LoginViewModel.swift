//
//  LoginViewModel.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import SwiftUI

@MainActor final class LoginViewModel: ObservableObject {
    
    private lazy var auth = FirebaseAuth()
    
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorOnLogin = false
    @Published var errorText = "Error while logging in"
    
    func login() {
        auth.login(email: email, password: password) { result in
            switch result {
            case .success:
                // Move to profile page
                self.errorOnLogin = false
            case .failure:
                self.errorOnLogin = true
            }
        }
    }
}
