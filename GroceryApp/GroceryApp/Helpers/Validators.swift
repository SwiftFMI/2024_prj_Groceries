//
//  Validators.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 18.02.25.
//

import SwiftUI

class Validators {
    func validatePass(pass: String) -> (Bool, String){
        if pass.count < 6 {
            return (false,"The password must be at least 6 characters")
        }
        else if !pass.contains(where: { ch in ch.isNumber }) {
            return (false,"The password must contain at least 1 number")
        }
        return (true,"")
    }
    
    func validateEmail(email: String) -> (Bool, String){
        let emailRegex = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        let isEmailValid = predicate.evaluate(with: email)

        let emailErrorMessage = isEmailValid ? "" : "Invalid email format"
        
        return(isEmailValid, emailErrorMessage)
    }
    
    func validateUsername(userName: String) -> (Bool, String){
        if userName.count < 3 {
            return (false,"The username must be at least 3 characters")
        }

        return (true,"")
    }
}
