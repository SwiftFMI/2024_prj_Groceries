//
//  RegisterViewModel.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 16.02.25.
//

import SwiftUI

@MainActor final class RegisterViewModel: ObservableObject {
    
    private lazy var auth = FirebaseAuth()
    
    
    @Published var password = ""
    @Published var confirmPass = ""
    @Published var isPassValid = true
    
    @Published var arePasswordsMatching = true
    @Published var passErrorMessage = ""
    @Published var confirmPassErrorMessage = ""
    
    @Published var errorOnRegister = false
    @Published var errorText = "Error while registering"
    
    @Published var email = ""

    @Published var isEmailValid = true
    @Published var emailErrorMessage = ""
    
    func validateEmail(email: String) {
        let emailRegex = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        isEmailValid = predicate.evaluate(with: email)

        emailErrorMessage = isEmailValid ? "" : "Invalid email format"
    }
    
    func validatePass(pass: String){
        if pass.count < 6 {
            isPassValid = false
            passErrorMessage = "The password must be at least 6 characters"
            return
        }
        else if !pass.contains(where: { ch in ch.isNumber }) {
            isPassValid = false
            passErrorMessage = "The password must contain at least 1 number"
            return
        }
        
        isPassValid = true
        
        passErrorMessage = isPassValid ? "" : "Invalid password format"
        
    }
    
    func passwordsMatch(confirmPass: String){
        if password != confirmPass {
            arePasswordsMatching = false
            confirmPassErrorMessage = "The passwords don't match"
            return
        }
        
        arePasswordsMatching = true
        confirmPassErrorMessage = arePasswordsMatching ? "" :"The passwords don't match"
        
    }
    
    
    func register() {
        auth.register(email: email, password: password) { result in
            switch result {
            case .success:
                // Move to profile page
                self.errorOnRegister = false
                print(self.auth.isLoggedIn())
            case .failure:
                self.errorOnRegister = true
            }
        }
    }
    
    
}
