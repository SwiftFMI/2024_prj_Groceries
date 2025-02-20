//
//  ProfileView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var vm : ProfileViewModel
    
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
                
                if (vm.isUserLogged) {
                    infoView
                } else {
                    ButtonsToAuth(
                        toLogin: vm.toLogin,
                        toRegister: vm.toRegister
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
                    if vm.isEditing {
                        TextEditView(
                            text: $vm.username,
                            isTextValid: $vm.isUsernameValid,
                            validateText: { uName in
                                vm.validateUsername(userName: uName)
                            },
                            textErrorMessage: $vm.usernameErrorMessage,
                            placeHolder: "Username"

                        )
                    } else {
                        Text(vm.username)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                }
                
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if vm.isEditing {
                        TextEditView(
                            text: $vm.email,
                            isTextValid: $vm.isEmailValid,
                            validateText: { email in
                                vm.validateEmail(email: email)
                            },
                            textErrorMessage: $vm.emailErrorMessage
                        )
                        Text("Password for confirmation")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        PasswordTextView(
                            pass: $vm.password,
                            isPassValid: $vm.isPassValid,
                            validatePass: { pass in
                                vm.validatePass(pass: pass)
                            },
                            passErrorMessage: $vm.passErrorMessage,
                            confirmPass: false
                        )
                    } else {
                        Text(vm.email)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                }
                
            }.padding(.horizontal, 24)
            
            Button(action: {
                        print("Shops button tapped!")
                        vm.toMap()
                    }) {
                        HStack {
                            Image(systemName: "cart.fill") // Cart icon
                                .foregroundColor(.primary)

                            Text("View Shops nearby") // Text label
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)

                            Spacer() // Pushes the arrow to the right

                            Image(systemName: "chevron.right") // Right arrow
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
                        )
                    }

            Button(action: {
                if vm.isEditing {
                    vm.save()
                }
                withAnimation{
                    vm.isEditing.toggle()
                }
            }) {
                Text(vm.isEditing ? "Save" : "Edit Profile")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(vm.isEditing ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
            }.alert(vm.errorText, isPresented: $vm.errorOnEdit) {
                Button("OK", role: .cancel) { }
            }
            
            if !vm.isEditing{
                Button(action: {
                    vm.logout()
                }) {
                    Text("Logout")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(vm.isEditing ? Color.green : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                }.alert(vm.errorText, isPresented: $vm.errorOnLogout) {
                    Button("OK", role: .cancel) { }
                }
                
            }
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

