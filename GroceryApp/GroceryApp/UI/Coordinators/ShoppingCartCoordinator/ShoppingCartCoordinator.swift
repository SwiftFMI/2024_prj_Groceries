//
//  ShoppingCartCoordinator.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

final class ShoppingCartCoordinator: Coordinator, ObservableObject {
    @Published var path = [ShoppingCartDestination]()
    private var auth: FirebaseAuth
    var initialDestination: ShoppingCartDestination!

    @MainActor
    init(auth: FirebaseAuth) {
        self.auth = auth

        let shoppingCartViewModel = ShoppingCartViewModel(
            auth: auth
        ){ [weak self] in
            RoadBlockViewModel {
                self?.transitionToLogin()
            } toRegister: {
                self?.transitionToRegister()
            }
            
        }
        
        self.initialDestination = .shoppingCart(viewModel: shoppingCartViewModel)
    }
    
    func start() -> some View {
        ShoppingCartCoordinatorView(coordinator: self)
    }
    
    private func loginDestination() -> ShoppingCartDestination {
        .login(viewModel: LoginViewModel(
            auth: auth,
            onSuccessfullLogin: {
                self.transitionToShoppingCart()
            }
        ))
    }
    
    
    private func registerDestination() -> ShoppingCartDestination {
        .register(viewModel: RegisterViewModel(
            auth: auth,
            onSuccessRegister: {
                self.transitionToShoppingCart()
            }
        ))
    }
    
    private func transitionToLogin(){
        self.path.append(self.loginDestination())
    }
    
    private func transitionToRegister(){
        self.path.append(self.registerDestination())
    }
    
    private func transitionToShoppingCart(){
        path.removeAll()
    }
}
