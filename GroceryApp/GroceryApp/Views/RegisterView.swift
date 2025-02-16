//
//  RegisterView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 16.02.25.
//
import SwiftUI

struct RegisterView: View {
    
    @State var vm: RegisterViewModel = RegisterViewModel()
    
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
                    vm.register()
                } label: {
                    Text("Register")
                }
                .alert("Error while registering", isPresented: $vm.errorOnRegister) {
                    Button("OK", role: .cancel) { }
                }

            }
        }
    }
}
