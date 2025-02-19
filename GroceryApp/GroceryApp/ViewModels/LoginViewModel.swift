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
    @Published var isEmailValid = true
    @Published var emailErrorMessage = ""
    
    @Published var password = ""
    @Published var passErrorMessage = ""
    @Published var isPassValid = true
    
    @Published var errorOnLogin = false
    @Published var errorText = "Error while logging in"
    
    
    func validateEmail(email: String) {
        let res = Validators().validateEmail(email: email)
        isEmailValid = res.0
        emailErrorMessage = res.1
    }
    
    func validatePass(pass: String){
        let res = Validators().validatePass(pass: pass)
        isPassValid = res.0
        passErrorMessage = res.1
    }
    
    
    func login() {
        auth.login(email: email, password: password) { result in
            switch result {
            case .success:
                // Move to profile page
                self.errorOnLogin = false
                print(self.auth.isLoggedIn())

            case .failure:
                self.errorOnLogin = true
            }
        }
    }
}
