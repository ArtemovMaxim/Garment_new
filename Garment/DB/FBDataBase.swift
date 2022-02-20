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
    
    func creatUserTimeLineProducts(completion: @escaping ([Product]) -> ()) {
            Firestore.firestore()
            //        получаем список Магазинов
                .collection("stores")
                .getDocuments { stores, error in
                    //                проходим по всем Магазинам
                    for store in stores!.documents {
                        let storeRef = store.reference
                        //                    заходим в Продукты
                        storeRef.collection("products")
                            .getDocuments { products, error in
                                //                            получаем все Продукты
                                let prods = products?.documents.compactMap({ Product(productDict: $0.data() )})
                                for prod in prods! {
                                    FBDataBase.allProdArray.append(prod)
                                    completion(FBDataBase.allProdArray)
                                }
                            }
                    }
                }

        }
}


