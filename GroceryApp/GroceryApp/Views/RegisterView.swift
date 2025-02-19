// RegisterView.swift
// GroceryApp
//
// Created by Zlatina Lilova on 16.02.25.
//
import SwiftUI

struct RegisterView: View {
    
    @StateObject var vm: RegisterViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Register")
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .padding(.top)
                
                TextEditView(
                    text: $vm.username,
                    isTextValid: $vm.isUsernameValid,
                    validateText: { uName in
                        vm.validateUsername(userName: uName)
                    },
                    textErrorMessage: $vm.usernameErrorMessage,
                    placeHolder: "Username"
                )
                
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
                
                PasswordTextView(
                    pass: $vm.confirmPass,
                    isPassValid: $vm.arePasswordsMatching,
                    validatePass: { pass in
                        vm.passwordsMatch(confirmPass: pass)
                    },
                    passErrorMessage: $vm.confirmPassErrorMessage,
                    confirmPass: true
                )
                
                Spacer()
                
                Button(action: {
                    vm.register()
                }) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .font(.headline)
                }
                .alert("Error while registering", isPresented: $vm.errorOnRegister) {
                    Button("OK", role: .cancel) { }
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
            
        }
    }
}


struct TextEditView: View {
    
    @Binding var text: String
    @Binding var isTextValid : Bool
    var validateText: (_ email: String) -> Void = {_ in }
    @Binding var textErrorMessage : String
    
    var placeHolder: String = "Email"
    
    var body : some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField(placeHolder, text: $text)
                .onChange(of: text, perform: { newValue in
                    validateText(newValue)
                })
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(!isTextValid ? Color.red : Color(.systemBlue), lineWidth: 1))
            
            if !isTextValid {
                Text(textErrorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
        .padding(.bottom, 16)
    }
}

struct PasswordTextView: View {
    
    @Binding var pass: String
    @Binding var isPassValid : Bool
    var validatePass: (_ pass: String) -> Void
    @Binding var passErrorMessage : String
    let confirmPass: Bool
    
    var text: String {
        confirmPass ? "Confirm password" : "Password"
    }
    
    var body : some View {
        VStack(alignment: .leading, spacing: 8) {
            SecureField(text, text: $pass)
                .onChange(of: pass, perform: { newValue in
                    validatePass(newValue)
                })
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(!isPassValid ? Color.red : Color(.systemBlue), lineWidth: 1))
            
            if !isPassValid {
                Text(passErrorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
        }
        .padding(.bottom, 16)
    }
}
