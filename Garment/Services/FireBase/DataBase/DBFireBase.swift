//
//  FBDataBase.swift
//  Garment
//
//  Created by Максим Артемов on 23.10.2021.
//

import Foundation
//import Firebase
//import FirebaseFirestore
//import FirebaseFirestoreSwift

struct DBFireBase {
    //
    static var count: Int = 0
    
    static var globalArrayAllProducts: [Product]?
    
    static var strAnyArr: [String] = []
    
    //    static var allProducts: [Product]?
    
    
    //    MARK: - все Товары с сортировкой по авторизованному Магазину
    //    загружаем словарь из БД для работы в приложении
    static func creatDB(completion: @escaping ([Product]) -> ()) {
        
//        let currentUser = Auth.auth().currentUser?.email // переменная с текущим юзером
//
//
//        let ref = Firestore.firestore()
//            .collection("stores").document(currentUser!)
//            .collection("products")
//
//
//        ref.getDocuments() { (document, error) in
//            let array = document?.documents.compactMap() { Product(productDict: $0.data())}
//            FBDataBase.globalArrayAllProducts = array
//            completion(array!)
//        }
    }
    
    static func creatStoreDescription(completion: @escaping (Store) -> ()) {
//        let currentUser = Auth.auth().currentUser?.email // переменная с текущим юзером
//
//        if AuthAccaunt.authProfile == .store {
//            let ref = Firestore.firestore()
//                .collection("stores").document(currentUser!)
//
//            ref.getDocument { settings, error in
//                completion(Store(storeDict: (settings?.data())!)!)
//            }
//        }
    }
    
    //    MARK: - все товары всех Магазинов
    static var allProdArray: [Product] = []
//    static var QueryDocumentSnapshot: [QueryDocumentSnapshot] = []

    static func creatUserTimeLineProducts(completion: @escaping ([Product]) -> ()) {
//        let db = Firestore.firestore()
//        let currentUser = Auth.auth().currentUser?.email
////        var indexProduct: Int = 1
//        var prodsCount: Int = 0
//
////        let query = db.collection("stores").whereField("productPostArticle", isNotEqualTo: "")
////        query.getDocuments { query1, err in
////            print("Query1: \(String(describing: query1?.count))")
////            for doc in query1!.documents {
////                FBDataBase.allProdArray.append(Product(productDict: doc.data())!)
////            }
////            completion(FBDataBase.allProdArray)
////            print("Выгружено из Query1: \(FBDataBase.allProdArray.count)")
////
////        }
//
//        db.collection("stores").document(currentUser!).collection("products").getDocuments { prods, err in
//            prodsCount = prods!.count
//
//            for prod in 1...prodsCount {
//                db.collection("stores").document(currentUser!).collection("products").document(String(prod)).getDocument { prod, err in
//                    FBDataBase.allProdArray.append(Product(productDict: (prod?.data())!)!)
//                    completion(FBDataBase.allProdArray)
//                    print("Выгружено: \(FBDataBase.allProdArray.count)")
//                }
//                prodsCount = 0
//            }
//        }
        

        

//// входим в список магазинов
//        db.collection("stores").getDocuments { stores, error in
//                print("Stores: \(String(describing: stores?.count))")
//
//// проходим по всем Магазинам
//                for store in stores!.documents {
//                    print("Stores forin: \(String(describing: stores?.count))")
//
//                    let storeRef = store.reference
//                    storeRef.document(currentUser!).collection("products")
//// заходим в Продукт
//                        .document(String(indexProduct)).getDocuments { product, error in
//                            print("Products: \(String(describing: product?.documents.count ))")
//// проходим по всем продуктам
//                        for product in product!.documents {
//// мапин проукты в массив
//                            let data = product.data()
//                            print("Дата: \(data.count)")
//                            indexProduct += 1
//                    }
//                        }
//
//
//                        }
//
//
//                }


//    }
}
}

