//
//  PickerViewModel.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 19.02.25.
//

import SwiftUI

struct PickerViewModel {

    var selectedItem: String?
    let items: [PickerItem]
    let onItemPicked: (PickerItem) -> Void

    var navigationTitle: String {
        "Sections"
    }

    func listBackgroundColor(_ item: PickerItem) -> Color {
        return selectedItem == item.label ? .blue : .clear
    }

    func listItemTextColor(_ item: PickerItem) -> Color? {
        return selectedItem == item.label ? .white : nil
    }
}
