//
//  DB.swift
//  Garment
//
//  Created by Максим Артемов on 12.09.2021.
//

import Foundation
import UIKit

class DataBase {
    
    //база данных всех продуктов
    static var db: [ProductPost] = []
    
    
    //создание тестового продукта
    
    static func addProductToDB() {
        
        let testProduct = ProductPost(productPostArticle: "\(String(ProductPost.generateNewArticle()))",
                                      productPostArrayPhotos: [],
                                      productPostFirstImage: UIImage(named: "1.jpeg")!,
                                      productPostTitle: "Название",
                                      productPostDescription: "Описание",
                                      productPostPrice: 100,
                                      productPostDiscont: 10,
                                      productPostFinalPrice: "90",
                                      productPostSex: .man,
                                      productPostSeason: .summer,
                                      productPostPublicationDate: Date(),
                                      productPostLikesCount: 1,
                                      productPostIsLiked: true,
                                      productPostViewsCount: 1,
                                      //                               productPostComments: ,
                                      productPostCommentsCount: 1,
                                      productPostIsNew: .isNew)
        DataBase.db.append(testProduct)
        //
        //        testProduct.productPostArticle = testProduct.generateNewArticle()
        
    }
    
    static func addNewProductToDB(product: ProductPost) {
        db.append(product)
    }
    
}
