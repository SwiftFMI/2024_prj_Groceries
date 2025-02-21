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
            
    private var cancellables = Set<AnyCancellable>()

    @MainActor @Published private(set) var fetchedCategories: [Category] = []

    var categoriesPublisher: AnyPublisher<[Category], Never> { $fetchedCategories.eraseToAnyPublisher() }

    func connect() {
        db = Firestore.firestore()
    }
    
    init(){
        self.connect()
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
            fetchedCategories = categories
            
        } catch {
            print("Error getting documents: \(error)")
        }
    }
    
    func fetchUserHistory(userID: String, completion: @escaping (Result<[ShoppingCartData], Error>) -> Void) async {
        do {
            guard let userHistoryDoc = try await db?.collection("History").document(userID).getDocument(),
                  let data = userHistoryDoc.data(),
                  let historyArray = data["data"] as? [[String: Any]] else {
                completion(.failure(Errors.UserHistoryFetchFailed))
                return
            }

            let shoppingHistory = historyArray.compactMap { ShoppingCartData(from: $0) }
            print("Fetched history: \(shoppingHistory)")
            completion(.success(shoppingHistory))

        } catch {
            print("Error getting history: \(error)")
            completion(.failure(error))
        }
    }
    
    func updateUserHistory(userID: String, newElement: ShoppingCartData){
        let userHistoryDoc = db?.collection("History").document(userID)
        let elementDict = newElement.toDictionary()

        userHistoryDoc?.getDocument { (document, error) in
            if let document = document, document.exists {
                userHistoryDoc?.updateData([
                    "data": FieldValue.arrayUnion([elementDict])
                ]) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        print("Successfully appended to array.")
                    }
                }
            } else {
                userHistoryDoc?.setData([
                    "data": [elementDict]
                ]) { error in
                    if let error = error {
                        print("Error creating document: \(error)")
                    } else {
                        print("Document created with new array.")
                    }
                }
            }
        }
    }
    
    
    func addMultipleCategories(categories: [Category]) async {
        do {
            for category in categories {
                let newDocRef = db?.collection("Categories").document() // Auto-generate ID
                
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
                
                try await newDocRef?.setData(categoryData)
                print("Added category: \(category.name) with ID: \(newDocRef?.documentID ?? "")")
            }
        } catch {
            print("Error adding categories: \(error.localizedDescription)")
        }
    }
}
