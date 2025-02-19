//
//  ProfileView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var vm = ProfileViewModel()
    
    let userImage = Image(systemName: "person.circle.fill")
    
    var body: some View {
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
                
            }
            
            Button(action: {
                if vm.isEditing {
                    vm.save()
                }
                vm.isEditing.toggle()
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
        }
        .padding(24)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .previewDevice("iPhone 14")
            .preferredColorScheme(.light) // Preview with Light mode
    }
}
