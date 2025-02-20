//
//  ProfileDestionation.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 17.02.25.
//

import SwiftUI

struct ProfileDestination {
    private let destination: NavigationDestination
    
    private init(destination: NavigationDestination) {
        self.destination = destination
    }
    
    static func profile(viewModel: ProfileViewModel) -> Self {
        .init(destination: .profile(viewModel: viewModel))
    }
    
    static func login(viewModel: LoginViewModel) -> Self {
        .init(destination: .login(viewModel: viewModel))
    }
    
    static func register(viewModel: RegisterViewModel) -> Self {
        .init(destination: .register(viewModel: viewModel))
    }
    
    static func map(viewModel: MapViewModel) -> Self {
        .init(destination: .map(viewModel: viewModel))
    }
}

extension ProfileDestination: Hashable {}

extension ProfileDestination: View {
    var body: some View {
        destination
    }
}
