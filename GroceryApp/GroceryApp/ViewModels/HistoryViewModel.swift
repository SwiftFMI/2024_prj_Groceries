//
//  HistoryViewModel.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 20.02.25.
//

import SwiftUI

final class HistoryViewModel: ObservableObject {
    
    var firebaseManager: FireStoreManager
    var toDetail: (ShoppingCartData) -> Void
    var auth: FirebaseAuth
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    @Published var lists: [ShoppingCartData] = []
    
    @Published var errorOnFetch = ""
    @Published var hasErrorOnFetch = false
    
    init(
        firebaseManager: FireStoreManager,
        auth: FirebaseAuth,
        toDetail: @escaping (ShoppingCartData) -> Void
    ) {
        self.firebaseManager = firebaseManager
        self.toDetail = toDetail
        self.auth = auth
    }
    
    func fetchHistoryLists() async {
        
        await firebaseManager.fetchUserHistory(userID: auth.currentUser?.uid ?? "") { result in
            DispatchQueue.main.async {  // ✅ Ensure UI updates happen on the main thread
                switch result {
                case .success(let list):
                    self.lists = list
                    print("\n\n \(self.lists) \(self.lists.count)")
                case .failure(let error):
                    self.hasErrorOnFetch = true
                    self.errorOnFetch = error.localizedDescription
                }
            }
        }
        
    }
    
}
