//
//  ProfileCoordinatorView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 15.02.25.
//

import SwiftUI

struct ProfileCoordinatorView: View {

    @ObservedObject var coordinator: ProfileCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.initialDestination
                .navigationDestination(for: ProfileDestionation.self) { $0 }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
