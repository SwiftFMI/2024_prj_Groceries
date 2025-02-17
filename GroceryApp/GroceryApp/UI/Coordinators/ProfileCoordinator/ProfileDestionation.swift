//
//  ProfileDestionation.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 17.02.25.
//

import SwiftUI

struct ProfileDestionation {
    private let destination: NavigationDestination

    private init(destination: NavigationDestination) {
        self.destination = destination
    }

    static func profile(viewModel: ProfileViewModel) -> Self {
        .init(destination: .profile(viewModel: viewModel))
    }
}

extension ProfileDestionation: Hashable {}

extension ProfileDestionation: View {
    var body: some View {
        destination
    }
}
