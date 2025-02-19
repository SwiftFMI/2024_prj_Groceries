//
//  RoadBlockViewModel.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 19.02.25.
//
import SwiftUI

final class RoadBlockViewModel: ObservableObject {
    
    let toLogin: () -> Void
    let toRegister: () -> Void
    
    init(toLogin: @escaping () -> Void, toRegister: @escaping () -> Void) {
        self.toLogin = toLogin
        self.toRegister = toRegister
    }
}
