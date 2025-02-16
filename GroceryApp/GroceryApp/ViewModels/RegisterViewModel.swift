//
//  RegisterViewModel.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 16.02.25.
//

import SwiftUI

@MainActor final class RegisterViewModel: ObservableObject {
    
    private lazy var auth = FirebaseAuth()
    
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorOnRegister = false
    @Published var errorText = "Error while registering"
    
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
