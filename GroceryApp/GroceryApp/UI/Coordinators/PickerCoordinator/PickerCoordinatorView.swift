//
//  PickerCoordinatorView.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 19.02.25.
//

import SwiftUI

struct PickerCoordinatorView: View {
    var coordinator: PickerCoordinator

    var body: some View {
        PickerView(viewModel: coordinator.pickerViewModel)
    }
}
