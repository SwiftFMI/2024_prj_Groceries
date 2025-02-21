//
//  PickerItem.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 19.02.25.
//

protocol PickerItem {
    var identifier: String { get }
    var label: String { get }
}

struct PickerSheetItem: PickerItem {
    var identifier: String
    var label: String
}

typealias PresentSectionPicker = ([PickerItem], String?, @escaping (PickerItem) -> Void) -> Void
