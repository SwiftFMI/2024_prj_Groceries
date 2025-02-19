//
//  LoginView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Text("Login")
               .font(.system(size: 50))
               .fontWeight(.heavy)
               .padding(.top)

            TextEditView(
                text: $viewModel.email,
                isTextValid: $viewModel.isEmailValid,
                validateText: { email in
                    viewModel.validateEmail(email: email)
                },
                textErrorMessage: $viewModel.emailErrorMessage
            )
            
            PasswordTextView(
                pass: $viewModel.password,
                isPassValid: $viewModel.isPassValid,
                validatePass: { pass in
                    viewModel.validatePass(pass: pass)
                },
                passErrorMessage: $viewModel.passErrorMessage,
                confirmPass: false
            )
            
            
            Button(action: {
                viewModel.login()
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .font(.headline)
            }
            .alert("Error while logging in", isPresented: $viewModel.errorOnLogin) {
                Button("OK", role: .cancel) { }
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 32)
    }
}
