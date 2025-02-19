//
//  HomeViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published private(set) var categories: [Category] = []
    @Published var currentSectionIndex: Int = 0

    let presentPicker: PresentSectionPicker
    let firebaseManager: FireStoreManager

    private var cancellables: Set<AnyCancellable> = []

    init(
        firebaseManager: FireStoreManager,
        currentSectionIndex: Int,
        presentPicker: @escaping PresentSectionPicker
    ) {
        self.firebaseManager = firebaseManager
        self.currentSectionIndex = currentSectionIndex
        self.presentPicker = presentPicker


    }

    var sectionName: String? {
        currentCategory?.name
    }

    private var currentCategory: Category? {
        guard categories.indices.contains(currentSectionIndex) else {
            return nil
        }
        return categories[currentSectionIndex]
    }

    private func configureCategoriesPublisher() {
        firebaseManager
            .categoriesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                guard let self = self else {
                    return
                }
                print("± \(categories)")
                self.categories = categories
            }
            .store(in: &cancellables)
    }
}
