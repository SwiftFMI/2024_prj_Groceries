//
//  ProfileView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel : ProfileViewModel
    
    let userImage = Image(systemName: "person.circle.fill")
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center, spacing: 32) {
                Text("Profile")
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .padding(.top)
                
                userImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                
                if (viewModel.isUserLogged) {
                    infoView
                } else {
                    ButtonsToAuth(
                        toLogin: viewModel.toLogin,
                        toRegister: viewModel.toRegister
                    )
                }
                
            }
            .padding(24)
        }
    }
    
    var infoView: some View {
        
        VStack(alignment: .leading, spacing: 32) {
            
            VStack(alignment: .leading, spacing: 32){
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if viewModel.isEditing {
                        TextEditView(
                            text: $viewModel.username,
                            isTextValid: $viewModel.isUsernameValid,
                            validateText: { uName in
                                viewModel.validateUsername(userName: uName)
                            },
                            textErrorMessage: $viewModel.usernameErrorMessage,
                            placeHolder: "Username"
                            
                        )
                    } else {
                        Text(viewModel.username)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if viewModel.isEditing {
                        TextEditView(
                            text: $viewModel.email,
                            isTextValid: $viewModel.isEmailValid,
                            validateText: { email in
                                viewModel.validateEmail(email: email)
                            },
                            textErrorMessage: $viewModel.emailErrorMessage
                        )
                        Text("Password for confirmation")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        PasswordTextView(
                            pass: $viewModel.password,
                            isPassValid: $viewModel.isPassValid,
                            validatePass: { pass in
                                viewModel.validatePass(pass: pass)
                            },
                            passErrorMessage: $viewModel.passErrorMessage,
                            confirmPass: false
                        )
                    } else {
                        Text(viewModel.email)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                }
                
            }.padding(.horizontal, 24)
            
            ShopsButton
            
            HistoryButton
            
            EditButton
            
            if !viewModel.isEditing {
                LogoutButton
            }
        }
    }
    
    var LogoutButton: some View {
        Button(action: {
            viewModel.logout()
        }) {
            Text("Logout")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isEditing ? Color.green : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding([.leading, .trailing], 20)
        }.alert(viewModel.errorText, isPresented: $viewModel.errorOnLogout) {
            Button("OK", role: .cancel) { }
        }
    }
    
    var EditButton : some View {
        Button(action: {
            if viewModel.isEditing {
                viewModel.save()
            }
            withAnimation{
                viewModel.isEditing.toggle()
            }
        }) {
            Text(viewModel.isEditing ? "Save" : "Edit Profile")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.isEditing ? Color.green : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding([.leading, .trailing], 20)
        }.alert(viewModel.errorText, isPresented: $viewModel.errorOnEdit) {
            Button("OK", role: .cancel) { }
        }
    }
    
    var ShopsButton : some View {
        Button(action: {
            if viewModel.isEditing {
                viewModel.isEditing.toggle()
                viewModel.resetEditing()
            }
            viewModel.toMap()
        }) {
            HStack {
                Image(systemName: "cart.fill")
                    .foregroundColor(.primary)
                
                Text("View Shops nearby")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
            )
            .padding([.leading, .trailing], 20)

        }
    }
    
    var HistoryButton : some View {
        Button(action: {
            if viewModel.isEditing {
                viewModel.isEditing.toggle()
                viewModel.resetEditing()
            }
            viewModel.toMap()
        }) {
            HStack {
                Image(systemName: "list.clipboard.fill")
                    .foregroundColor(.primary)
                
                Text("History")
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
            )
            .padding([.leading, .trailing], 20)

        }
    }
}

struct ButtonsToAuth: View {
    let toLogin: () -> Void
    let toRegister: () -> Void
    
    var body: some View{
        VStack(spacing: 24){
            Button(action: {
                toLogin()
            }) {
                Text("Login")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
            }
            Button(action: {
                toRegister()
            }) {
                Text("Register")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
            }
        }
    }
}

