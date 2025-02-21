//
//  ProfileViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 17.02.25.
//

import SwiftUI
import Combine
import FirebaseAuth

final class ProfileViewModel: ObservableObject {
    
    init(auth: FirebaseAuth,
         toLogin: @escaping () -> Void,
         toRegister: @escaping () -> Void,
         toMap: @escaping () -> Void,
         toHistory: @escaping () -> Void
    ){
        self.auth = auth
        self.isUserLogged = auth.isLoggedIn()
        self.user = auth.currentUser
        self.toLogin = toLogin
        self.toRegister = toRegister
        self.toMap = toMap
        self.toHistory = toHistory
        observeAuthChanges()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    
    private func observeAuthChanges() {
        auth.userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
                self?.email = user?.email ?? ""
                self?.username = user?.displayName ?? ""

                guard let user else {
                    self?.isUserLogged = false
                    return
                }
                self?.isUserLogged = true
            }
            .store(in: &cancellables)
    }
    
    private let auth: FirebaseAuth
    
    let toLogin: () -> Void
    let toRegister: () -> Void
    let toMap: () -> Void
    let toHistory: () -> Void
    
    @Published var isUserLogged: Bool
    var user: User?
    
    private var isEmailEdited = false
    private var isUserNameEdited = false
    
    @Published var email : String = ""
    @Published var isEmailValid = true
    @Published var emailErrorMessage = ""
    
    @Published var username : String = ""
    @Published var isUsernameValid = true
    @Published var usernameErrorMessage = ""
    
    @Published var isEditing = false
    
    @Published var password = ""
    @Published var passErrorMessage = ""
    @Published var isPassValid = true
    
    @Published var errorOnEdit = false
    @Published var errorOnLogout = false
    @Published var errorText = ""
    
    func validateEmail(email: String) {
        isEmailEdited = true
        let res = Validators.validateEmail(email: email)
        isEmailValid = res.0
        emailErrorMessage = res.1
    }
    
    func validateUsername(userName: String){
        isUserNameEdited = true
        let res = Validators.validateUsername(userName: userName)
        isUsernameValid = res.0
        usernameErrorMessage = res.1
    }
    
    func validatePass(pass: String){
        let res = Validators.validatePass(pass: pass)
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
                
            case .failure(let error):
                self.errorOnEdit = true
                self.errorText = "Error while updating email: \(error.localizedDescription)"
            }
        }
        
    }
    
    private func editUserName(){
        auth.editUserName(userName: username) { result in
            switch result {
            case .success():
                self.isEditing.toggle()
                
            case .failure(let error):
                self.errorOnEdit = true
                self.errorText = "Error while updating username: \(error.localizedDescription)"
            }
        }
    }
    
    func logout() {
        auth.logout { (result: Result<Bool, Error>) in
            switch result {
            case .success(let success):
                self.isUserLogged = !success
            case .failure(let error):
                self.errorOnLogout = true
                self.errorText = "Error while logging out: \(error.localizedDescription)"
            }
        }
    }
    
    func resetEditing(){
        isEmailEdited = false
        isUserNameEdited = false
        email = user?.email ?? ""
        username = user?.displayName ?? ""
        emailErrorMessage = ""
        usernameErrorMessage = ""
        password = ""
        passErrorMessage = ""
        isPassValid = true
        isEmailValid = true
        isUsernameValid = true
        
    }
}
