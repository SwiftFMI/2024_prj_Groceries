//
//  ShoppingCartUpdater.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 20.02.25.
//

import Combine
import SwiftUI

final class ShoppingCartUpdater: ObservableObject {
    @Published private(set) var shoppingCart: [ProductData: Int] = [:]

    let firebaseAuth: FirebaseAuth
    let firebaseManager: FireStoreManager

    var shoppingCartPublisher: AnyPublisher<[ProductData: Int], Never> { $shoppingCart.eraseToAnyPublisher() }
    private var cancellables = Set<AnyCancellable>()

    init(
        firebaseAuth: FirebaseAuth,
        firebaseManager: FireStoreManager
    ) {
        self.firebaseAuth = firebaseAuth
        self.firebaseManager = firebaseManager

        observeAuthChanges()
    }

    func addItem(_ item: ProductData) {
        if shoppingCart[item] != nil {
            shoppingCart[item]? += 1
        } else {
            shoppingCart[item] = 1
        }
    }

    func lowerItemCount(_ item: ProductData) {
        guard shoppingCart[item] != nil else { return }
        
        if shoppingCart[item]! == 1 {
            shoppingCart[item] = nil
        } else {
            shoppingCart[item]! -= 1
        }
    }

    func removeItem(_ item: ProductData) {
        guard shoppingCart[item] != nil else { return }

        shoppingCart[item] = nil
    }

    func finish() {
        guard shoppingCart != [:] else { return }
        firebaseManager.updateUserHistory(userID: firebaseAuth.currentUser?.uid ?? "" , newElement: ShoppingCartData(carts: shoppingCart))
        shoppingCart = [:]
    }

    private func observeAuthChanges() {
        firebaseAuth.userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.shoppingCart = [:]
            }
            .store(in: &cancellables)
    }
}
