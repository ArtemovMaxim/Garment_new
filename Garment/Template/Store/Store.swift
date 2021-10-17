//
//  Store.swift
//  Garment
//
//  Created by Максим Артемов on 10.09.2021.
//

import Foundation
import UIKit



struct Store {
    
    enum StoreCategory {
        case shoes //обувь
        case clothes //одежда
        case sportWears //спортивная одежда
        case swimsuits //купальники
        case furCoats //шубы
    }

    var logo: UIImage?
    var name: String
    var description: String
    
    var category: StoreCategory?
    

    var url: String?
    var instagram: String
    var vKontakte: String
    var odniklassniki: String
    var facebook: String
    
    var telephonNumber: String?
    var whatsAppLink: String?
    var whatsAppNumber: String?
    var email: String?
    
    
    var workTime: String?


    var followers: Any
    
    
//номенклатура
    var product: [Product]?
    
//    custom function
//    сортировка словаря всех продуктов по ключу магазина
    
    

    
}
