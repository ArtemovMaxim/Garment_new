//
//  DB.swift
//  Garment
//
//  Created by Максим Артемов on 12.09.2021.
//

import Foundation
import UIKit

struct DataBase {    
    
    //база данных магазинов
    static var stores: [String: Store] = [:] // описание одного магазина (со всем параметрами)
    //база данных всех продуктов
    static var productsDb: [Product] = [] // все продукт, которые отразятся в ленте User (без учета подиски на магазины)
    

    
    //добавление нового продукта в БД
    mutating func addNewProductToDB(product: Product) {
        DataBase.productsDb.append(product)
        
    }
    
    
    func generateArray(name: String) -> [Product] {
        
        guard name != "" else { return DataBase.productsDb }
        
            return  DataBase.productsDb.filter { $0.store ==  name}
    }
}
