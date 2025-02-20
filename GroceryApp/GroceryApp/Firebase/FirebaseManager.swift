//
//  FirebaseManager.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 13.02.25.
//

import Combine
import Firebase
import FirebaseFirestore

class FireStoreManager: ObservableObject {
    var db: Firestore?

    @MainActor @Published private(set) var fetchedCategories: [Category] = []

    var categoriesPublisher: AnyPublisher<[Category], Never> { $fetchedCategories.eraseToAnyPublisher() }

    private var cancellables = Set<AnyCancellable>()

    func connect() {
        db = Firestore.firestore()
    }
    
    init(){
        connect()
    }

    @MainActor
    func fetchCategories() async {
        do {
            guard let categoriesDoc = try await db?.collection("Categories").getDocuments(source: .default) else {
                print("No information!")
                return
            }

            var categories: [Category] = []
            for document in categoriesDoc.documents {
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
                categories.append(category)
            }
            print("± \(categories)")
            fetchedCategories = categories

        } catch {
          print("Error getting documents: \(error)")
        }
    }
    

    func addMultipleCategories(categories: [Category]) async {
        let db = Firestore.firestore()

        do {
            for category in categories {
                let newDocRef = db.collection("Categories").document() // Auto-generate ID
                
                let categoryData: [String: Any] = [
                    "name": category.name,
                    "products": category.products.map { product in
                        return [
                            "id": product.id,
                            "name": product.name,
                            "pricesLidl": product.pricesLidl,
                            "pricesKaufland": product.pricesKaufland,
                            "pricesBilla": product.pricesBilla
                        ]
                    }
                ]
                
                try await newDocRef.setData(categoryData)
                print("Added category: \(category.name) with ID: \(newDocRef.documentID)")
            }
        } catch {
            print("Error adding categories: \(error.localizedDescription)")
        }
    }
}
