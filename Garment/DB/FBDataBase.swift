//
//  FBDataBase.swift
//  Garment
//
//  Created by Максим Артемов on 23.10.2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FBDataBase {
    //
    static var count: Int = 0
    
    static var globalArrayAllProducts: [Product]?
    
    //    static var allProducts: [Product]?
    
    
    //    MARK: - все Товары с сортировкой по авторизованному Магазину
    //    загружаем словарь из БД для работы в приложении
    static func creatDB(completion: @escaping ([Product]) -> ()) {
        
        let currentUser = Auth.auth().currentUser?.email // переменная с текущим юзером
        
        
        let ref = Firestore.firestore()
            .collection("stores").document(currentUser!)
            .collection("products")
        
        
        ref.getDocuments() { (document, error) in
            let array = document?.documents.compactMap() { Product(productDict: $0.data())}
            FBDataBase.globalArrayAllProducts = array
            completion(array!)
        }
    }
    
    static func creatStoreDescription(completion: @escaping (Store) -> ()) {
        let currentUser = Auth.auth().currentUser?.email // переменная с текущим юзером
        
        if AuthAccaunt.authProfile == .store {
            let ref = Firestore.firestore()
                .collection("stores").document(currentUser!)
            
            ref.getDocument { settings, error in
                completion(Store(storeDict: (settings?.data())!)!)
            }
        }
    }
    
    //    MARK: - все товары всех Магазинов
    static var allProdArray: [Product] = []
//    static var QueryDocumentSnapshot: [QueryDocumentSnapshot] = []

    static func creatUserTimeLineProducts(completion: @escaping ([Product]) -> ()) {
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser?.email
        let indexProduct: Int = 1
        //        получаем список Магазинов
//        db.collection("stores")
        
        let stores = db.collection("stores")

        
//        let wf = strs.whereField("productPostArticle", isNotEqualTo: "0")
//        wf.getDocuments { product, error in
////                for prod in product!.documents {
////                    prod.
////                }
//            FBDataBase.QueryDocumentSnapshot = product!.documents
//            print("FBDataBase.QueryDocumentSnapshot: \(FBDataBase.QueryDocumentSnapshot.count)")
//            }
//
//        FBDataBase.allProdArray = (FBDataBase.QueryDocumentSnapshot.compactMap({ Product(productDict: $0.data() )}))
//        print("creatUserTimeLineProducts: \(FBDataBase.allProdArray.count)")
//        completion(FBDataBase.allProdArray)

        
// входим в список магазинов
            .getDocuments { stores, error in
                print("Stores: \(String(describing: stores?.count))")
// проходим по всем Магазинам
                for store in stores!.documents {
                    let storeRef = store.reference
                    let curStore = storeRef.collection(currentUser!).document("products")
// заходим в Продукт
                    curStore.collection(String(indexProduct)).getDocuments { products, error in
// проходим по всем продуктам
                        for product in products!.documents {
// мапин проукты в массив
                            FBDataBase.allProdArray.append(Product(productDict: product.data())!)
                        }
                            
                            
                        }
                    
                    
                }
            }
        completion(FBDataBase.allProdArray)

    }
}


