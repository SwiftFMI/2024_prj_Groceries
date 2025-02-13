//
//  Coordinator.swift
//  GroceriesApp
//
//  Created by Nikolay Dinkov on 9.02.25.
//

import SwiftUI

protocol Coordinator: AnyObject {
    associatedtype SwiftUIView: View

    @ViewBuilder
    func start() -> SwiftUIView
}
