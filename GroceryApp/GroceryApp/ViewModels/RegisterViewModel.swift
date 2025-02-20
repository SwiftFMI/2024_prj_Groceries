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
    
    @Published var username = ""
    @Published var isUsernameValid = true
    @Published var usernameErrorMessage = ""
    
    func validateEmail(email: String) {
        let res = Validators.validateEmail(email: email)
        isEmailValid = res.0
        emailErrorMessage = res.1
    }
    
    func validatePass(pass: String){
        let res = Validators.validatePass(pass: pass)
        isPassValid = res.0
        passErrorMessage = res.1
    }
    
    func passwordsMatch(confirmPass: String){
        if password != confirmPass {
            arePasswordsMatching = false
            confirmPassErrorMessage = "The passwords don't match"
            return
        }
        
        arePasswordsMatching = true
        confirmPassErrorMessage = ""
        
    }
    
    func validateUsername(userName: String){
        let res = Validators.validateUsername(userName: userName)
        isUsernameValid = res.0
        usernameErrorMessage = res.1
    }
    
    
    func register() {
        auth.register(email: email, password: password, name: username) { result in
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
