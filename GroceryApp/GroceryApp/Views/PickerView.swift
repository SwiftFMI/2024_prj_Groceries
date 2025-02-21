//
//  PickerView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 19.02.25.
//

import SwiftUI

struct PickerView: View {
    @Environment(\.dismiss) private var dismiss
    let viewModel: PickerViewModel

    var body: some View {
        NavigationStack {
            itemsListView
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(viewModel.navigationTitle)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Close")
                        })
                    }
                }
        }
    }

    private var itemsListView: some View {
        List(viewModel.items, id: \.identifier) { item in
            sectionRow(item: item)
        }
    }

    private func sectionRow(item: PickerItem) -> some View {
        Button(
            action: {
                handleItemSelection(item)
            },
            label: {
                Text(item.label)
                    .foregroundColor(viewModel.listItemTextColor(item))
            }
        )
        .listRowBackground(viewModel.listBackgroundColor(item))
    }

    private func handleItemSelection(_ item: PickerItem) {
        viewModel.onItemPicked(item)
        dismiss()
    }
}
