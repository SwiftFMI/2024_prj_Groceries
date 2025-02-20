//
//  ShoppingCartViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI
import FirebaseAuth
import Combine

final class ShoppingCartViewModel: ObservableObject {
    
    let auth: FirebaseAuth
    let createRoadBlockViewModelAction: () -> RoadBlockViewModel
    private var cancellables = Set<AnyCancellable>()
    
    
    init(
        auth: FirebaseAuth,
        createRoadBlockViewModelAction: @escaping () -> RoadBlockViewModel
    ) {
        self.auth = auth
        self.createRoadBlockViewModelAction = createRoadBlockViewModelAction
        observeAuthChanges()
    }
    
    private func observeAuthChanges() {
        auth.authStatePublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLogged, user in
                self?.isUserLogged = isLogged
                self?.currentUser = user
                
            }
            .store(in: &cancellables)
    }
    
    @Published var isUserLogged = false
    var currentUser: User? = nil
    
}
