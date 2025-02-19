//
//  PickerPresentable.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 19.02.25.
//

protocol PickerPresentable: AnyObject {
    func presentPicker(with items: [PickerItem], currentCategoryId: String?, onItemPicked: @escaping (PickerItem) -> Void)
    var sheetCoordinator: IdentifiableCoordinator? { get set }
}

extension PickerPresentable {
    func presentPicker(
        with items: [PickerItem],
        currentCategoryId: String?,
        onItemPicked: @escaping (PickerItem) -> Void
    ) {
        let viewModel = PickerViewModel(
            selectedItem: currentCategoryId ?? items[0].label,
            items: items
        ) { selectedItem in
            onItemPicked(selectedItem)
        }
        let pickerCoordinator = PickerCoordinator(pickerViewModel: viewModel)
        sheetCoordinator = IdentifiableCoordinator(coordinator: pickerCoordinator)
    }
}
