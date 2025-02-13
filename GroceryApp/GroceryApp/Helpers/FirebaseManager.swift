//
//  FirebaseManager.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 13.02.25.
//

import Firebase
import FirebaseFirestore

class FireStoreManager: ObservableObject {
    var db: Firestore?
    
    @Published var fetchedCategories: [Category] = []

    func connect() {
        db = Firestore.firestore()
    }
    
    init(){
        connect()
    }
    
    func fetchCategories() async {
        do {
            guard let categories = try await db?.collection("Categories").getDocuments(source: .cache) else {
                print("No information!")
                return
            }
            
            
            for document in categories.documents {
                let data = document.data()
                let name = data["name"] as? String ?? "Unknown Category"
                let id = document.documentID

                let productDataArray = data["products"] as? [[String: Any]] ?? []
                let products: [ProductData] = productDataArray.compactMap { productDict in
                   ProductData(
                       id: productDict["id"] as? Int ?? 0,
                       name: productDict["name"] as? String ?? "Unknown Product",
                       pricesLidl: productDict["pricesLidl"] as? [String: Double] ?? [:],
                       pricesKaufland: productDict["pricesKaufland"] as? [String: Double] ?? [:],
                       pricesBilla: productDict["pricesBilla"] as? [String: Double] ?? [:]
                   )
               }

                let category = Category(id: id, name: name, products: products)
                print("Fetched: \(category)")
                fetchedCategories.append(category)
            }
            
        } catch {
          print("Error getting documents: \(error)")
        }
    }
}
