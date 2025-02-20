//
//  HomeView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 14.02.25.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel: HomeViewModel

    var body: some View {
        contentView
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.sectionName ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { @MainActor in
                        let pickerItems = viewModel.categories.pickerItems
                        if !pickerItems.isEmpty {
                            let currentSectionId = viewModel.sectionName
                            viewModel.presentPicker(pickerItems, currentSectionId) { item in
                                viewModel.changeCategory(to: item.identifier)
                            }
                        }
                    }, label: {
                        Text("Categories")
                    })
                }
            }
    }

    private var contentView: some View {
        TabView(selection: $viewModel.currentCategoryIndex) {
            ForEach(Array(viewModel.categories.enumerated()), id: \.element.id) { (index, element) in
                categoryView(category: element)
                    .id(element.id)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    private func categoryView(category: Category) -> some View {
        List {
            ForEach(category.products, id: \.id) { product in
                HStack {
                    Text(product.name)
                    Spacer()
                    VStack {
                        Text("Average Price:")
                        Text(String(format: "%.2f", viewModel.averagePrice(for: product)) + " лв.")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.openProductPageAction(product)
                }
            }
        }
    }
}
