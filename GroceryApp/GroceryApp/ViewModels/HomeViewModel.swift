//
//  HomeViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published private(set) var categories = [Category]()
    @Published var currentSectionIndex: Int = 0

    let presentPicker: PresentSectionPicker

    init(
        categories: [Category] = [Category](),
        currentSectionIndex: Int,
        presentPicker: @escaping PresentSectionPicker
    ) {
        self.categories = categories
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
}
