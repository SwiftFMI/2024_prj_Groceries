//
//  LoginView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var vm: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Text("Login")
               .font(.system(size: 50))
               .fontWeight(.heavy)
               .padding(.top)

            TextEditView(
                text: $vm.email,
                isTextValid: $vm.isEmailValid,
                validateText: { email in
                    vm.validateEmail(email: email)
                },
                textErrorMessage: $vm.emailErrorMessage
            )
            
            PasswordTextView(
                pass: $vm.password,
                isPassValid: $vm.isPassValid,
                validatePass: { pass in
                    vm.validatePass(pass: pass)
                },
                passErrorMessage: $vm.passErrorMessage,
                confirmPass: false
            )
            
            
            Button(action: {
                vm.login()
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .font(.headline)
            }
            .alert("Error while logging in", isPresented: $vm.errorOnLogin) {
                Button("OK", role: .cancel) { }
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 32)
    }
}
