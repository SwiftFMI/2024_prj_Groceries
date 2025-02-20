//
//  HistoryViewModel.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 20.02.25.
//

import SwiftUI

final class HistoryViewModel: ObservableObject {
    
    var firebaseManager: FireStoreManager
    var toDetail: (String) -> Void
    var auth: FirebaseAuth
    
    @Published var lists: [String] = []
    
    @Published var errorOnFetch = ""
    @Published var hasErrorOnFetch = false
    
    init(
        firebaseManager: FireStoreManager,
        auth: FirebaseAuth,
        toDetail: @escaping (String) -> Void
    ) {
        self.firebaseManager = firebaseManager
        self.toDetail = toDetail
        self.auth = auth
    }
    
    func fetchCategories() async {
        await firebaseManager.fetchUserHistory(userID: auth.currentUser?.uid ?? "") { result in
            switch result {
            case .success(_):
                self.lists = self.firebaseManager.currentUserHistory
            case .failure(let error):
                self.hasErrorOnFetch = true
                self.errorOnFetch = error.localizedDescription
            }
        }
    }
    
}
