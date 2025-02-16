//
//  LoginView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import SwiftUI

struct LoginView: View {
    
    @State var vm: LoginViewModel = LoginViewModel()
    
    var body: some View {
        Form {
            Section{
                TextField("Email", text: $vm.email)
            }
            Section{
                TextField("Password", text: $vm.password)
            }
            
            Section{
                Button {
                    vm.login()
                } label: {
                    Text("Login")
                } .alert("Error", isPresented: $vm.errorOnLogin) {
                    Button("OK", role: .cancel) { }
                }

            }
        }
    }
}
