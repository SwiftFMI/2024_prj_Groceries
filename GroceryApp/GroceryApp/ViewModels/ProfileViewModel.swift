//
//  ProfileViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 17.02.25.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    private let auth = FirebaseAuth()

    @Published var isEmailEdited = false
    @Published var isUserNameEdited = false
    
    @Published var email = ""
    @Published var isEmailValid = true
    @Published var emailErrorMessage = ""
    
    @Published var username = ""
    @Published var isUsernameValid = true
    @Published var usernameErrorMessage = ""
    
    @Published var isEditing = false
    
    @Published var password = ""
    @Published var passErrorMessage = ""
    @Published var isPassValid = true
    
    @Published var errorOnEdit = false
    @Published var errorText = ""
    
    func validateEmail(email: String) {
        isEmailEdited = true
        let res = Validators().validateEmail(email: email)
        isEmailValid = res.0
        emailErrorMessage = res.1
    }
    
    func validateUsername(userName: String){
        isUserNameEdited = true
        let res = Validators().validateUsername(userName: userName)
        isUsernameValid = res.0
        usernameErrorMessage = res.1
    }
    
    func validatePass(pass: String){
        let res = Validators().validatePass(pass: pass)
        isPassValid = res.0
        passErrorMessage = res.1
    }
    
    func save(){
        if isEmailEdited {
            editEmail()
        }
        if isUserNameEdited {
            editUserName()
        }
    }
    
    private func editEmail(){
        auth.editEmail(newEmail: email, password: password){ result in
            switch result {
            case .success():
                self.isEditing.toggle()
                
            case .failure(_):
                self.errorOnEdit = true
                self.errorText = "Error while updating email"
            
            }
        }
        
    }
    
    private func editUserName(){
        auth.editUserName(userName: username) { result in
            switch result {
            case .success():
                self.isEditing.toggle()
                
            case .failure(_):
                self.errorOnEdit = true
                self.errorText = "Error while updating email"
            }
        }
    }
    
}
