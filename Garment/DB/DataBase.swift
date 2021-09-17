//
//  DB.swift
//  Garment
//
//  Created by Максим Артемов on 12.09.2021.
//

import Foundation
import UIKit

struct DataBase {
    
    //база данных всех продуктов
   var db = [ProductPost]()
    
    
    //создание тестового продукта
    
    mutating func addProductToDB() {
            
        let testProduct = ProductPost(productPostArticle: "\(String(ProductPost.generateNewArticle()))",
                             productPostImage: UIImage(named: "1.jpeg")!,
                             productPostTitle: "Название",
                             productPostDescription: "Описание",
                             productPostPrice: 100,
                             productPostDiscont: 10,
                             //                             productPostFinalPrice: ,
                             productPostSex: .man,
                             productPostSeason: .summer,
                             productPostPublicationDate: Date(),
                             productPostLikesCount: 1,
                             productPostIsLiked: true,
                             productPostViewsCount: 1,
                             //                               productPostComments: ,
                             productPostCommentsCount: 1,
                             productPostIsNew: .isNew)
        db.append(testProduct)
//
//        testProduct.productPostArticle = testProduct.generateNewArticle()
        
    }
    
}
