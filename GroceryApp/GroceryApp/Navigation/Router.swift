//
//  Router.swift
//  GroceryApp
//
//  Created by Nikolay Dinkov on 13.02.25.
//

import SwiftUI

final class Router: ObservableObject {

    @Published var appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }
}
