//
//  DB.swift
//  Garment
//
//  Created by Максим Артемов on 12.09.2021.
//

import Foundation
import UIKit

struct DataBase {    
    
    //база данных всех магазинов
    static var allStoresDB: [String: Store] = [:] // все магазины
    //база данных всех продуктов
    static var allProductsDB: [Product] = [] // все продукт, которые отразятся в ленте User (без учета подиски на магазины)
    
    
    //    сортировка Продуктов по названию Магазина
    static func generateArray(name: String) -> ([Product], Int?) {
        
        guard name != "" else { return (DataBase.allProductsDB, DataBase.allProductsDB.count) }
        
        //        let filteredDB = DataBase.allProductsDB.filter { $0.store == name}
        let filteredDB = DataBase.allProductsDB.compactMap { (filtered) -> Product? in
            if filtered.store == name {
                return filtered
            } else { return nil}
        }
        return (filteredDB, filteredDB.count)
    }
}
