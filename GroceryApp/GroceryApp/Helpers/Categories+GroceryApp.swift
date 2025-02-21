//
//  Categories+GroceryApp.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 19.02.25.
//

extension [Category] {
    var pickerItems: [PickerItem] {
        compactMap {
            if let id = $0.id {
                return PickerSheetItem(identifier: id, label: $0.name)
            }
            return nil
        }
    }
}
