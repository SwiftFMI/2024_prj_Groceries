//
//  PickerViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 19.02.25.
//

struct PickerViewModel {

    var selectedItem: String?
    let items: [PickerItem]
    let onItemPicked: (PickerItem) -> Void

    var navigationTitle: String {
        "Sections"
    }
}
