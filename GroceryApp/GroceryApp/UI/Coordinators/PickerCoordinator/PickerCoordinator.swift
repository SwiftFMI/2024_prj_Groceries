//
//  PickerCoordinator.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 19.02.25.
//

import SwiftUI

final class PickerCoordinator: Coordinator {
    let pickerViewModel: PickerViewModel

    init(pickerViewModel: PickerViewModel) {
        self.pickerViewModel = pickerViewModel
    }

    func start() -> some View {
        PickerCoordinatorView(coordinator: self)
    }
}
