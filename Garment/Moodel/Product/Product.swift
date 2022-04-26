//
//  Product.swift
//  Garment
//
//  Created by Максим Артемов on 10.09.2021.
//

import Foundation
import UIKit

protocol arrayProductsProtocol {
    init? (productDict: [String: Any])
}

// структура Сообщений
struct message: Codable {
    var author: String
    var text: String
    var date: Date
}

struct Product/*: Codable*/ {
    init(store: String?,
         productPostArticle: String,
         productPostTitle: String,
         productPostDescription: String,
         productPostImageCount: Int,
         productPostPrice: Double,
         productPostDiscont: Double,
         productPostFinalPrice: Double,
         productPostSex: String,
         productPostSeason: String,
         productPostPublicationDate: Date,
         productPostLikesCount: Int,
         productPostIsLiked: Bool?,
         productLikes: [String]?,
         productFollowers: [String]?,
         productPostViewsCount: Int,
         productPostPhotoCount: Int,
         productPostIsNew: String,
         indexNumberOfProduct: Int,
         productPostArrayPhotos: [UIImage]?,
         messages: [message]?)
    {
        self.store = store ?? "Название магазина"
        self.productPostArticle = productPostArticle
        self.productPostTitle = productPostTitle
        self.productPostDescription = productPostDescription
        self.productPostImageCount = productPostImageCount
        self.productPostPrice = productPostPrice
        self.productPostDiscont = productPostDiscont
        self.productPostFinalPrice = productPostFinalPrice
        self.productPostSex = productPostSex
        self.productPostSeason = productPostSeason
        self.productPostPublicationDate = productPostPublicationDate
        self.productPostLikesCount = productPostLikesCount
        self.productPostIsLiked = productPostIsLiked ?? false
        self.likes = productLikes ?? []
        self.followers = productFollowers ?? []
        self.productPostViewsCount = productPostViewsCount
        self.productPostPhotoCount = productPostPhotoCount
        self.productPostIsNew = productPostIsNew
        self.indexNumberOfProduct = indexNumberOfProduct
        self.productPostArrayPhotos = productPostArrayPhotos
        self.messages = messages ?? []
    }
    
    
    //магазин
    var store: String = ""
    
    //артукул
    var productPostArticle: String
    
    //описание товара
    var productPostArrayPhotos: [UIImage]?
    var productPostTitle: String
    var productPostDescription: String
    var productPostImageCount: Int
    
    //стоимость товара
    var productPostPrice: Double
    var productPostDiscont: Double
    var productPostFinalPrice: Double
    
    //параметры товара
    var productPostSex: String
    var productPostSeason: String
    
    //параметры поста
    var productPostPublicationDate: Date?
    var productPostLikesCount: Int
    var productPostIsLiked: Bool
    var likes: [String]
    var followers: [String]
    
    // сообщения
    var messages: [message]
    
    var productPostViewsCount: Int
    var productPostPhotoCount: Int
    
    var indexNumberOfProduct: Int
    
    //новизна товара
    var productPostIsNew: String
    
    //параментры товара
    enum Sex: String {
        case man = "Для мужчин"
        case woman = "Для женщин"
        case unisex = "Унисекс"
    }
    
    enum Season: String{
        case winter = "Зима"
        case spring = "Весна"
        case summer = "Лето"
        case autumn = "Осень"
    }
    
    enum New: String {
        case isNew = "Новинка"
        case normal = ""
        case sale = "Скидки"
    }
    
    //функции
    //функция генерации нового артикула
    static func generateNewArticle() -> String {
        let date = Date()
        let calendar = NSCalendar.current
        let day = calendar.component(.day, from: date as Date)
        let hour = calendar.component(.hour, from: date as Date)
        let minute = calendar.component(.minute, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let second = calendar.component(.second, from: date as Date)
        let randomNumder = arc4random()
        let newArticle = "\(randomNumder)" + " " +  "\(month)" + " " +  "\(day)" + " " + "\(hour)" + " " + "\(minute)" + " " + "\(second)"
        
        return newArticle
    }
}


extension Product: arrayProductsProtocol {
    init? (productDict: [String : Any]) {
        guard let productPostArticle = productDict["productPostArticle"] as? String,
              let productPostArrayPhotos = productDict["productPostArrayPhotos"] as? [UIImage],
              let productPostTitle = productDict["productPostTitle"] as? String,
              let productPostDescription = productDict["productPostDescription"] as? String,
              let productPostPrice = productDict["productPostPrice"] as? Double,
              let productPostDiscont = productDict["productPostDiscont"] as? Double,
              let productPostFinalPrice = productDict["productPostFinalPrice"] as? Double,
              let productPostSex = productDict["productPostSex"] as? String,
              let productPostSeason = productDict["productPostSeason"] as? String,
              let productPostPublicationDate = productDict["productPostPublicationDate"] as? Date,
              let productPostLikesCount = productDict["productPostLikesCount"] as? Int,
              let productPostIsLiked = productDict["productPostIsLiked"] as? Bool,
              let productLikes = productDict["productLikes"] as? [String],
              let productPostViewsCount = productDict["productPostViewsCount"] as? Int,
              let store = productDict["store"] as? String,
              let productPostIsNew = productDict["productPostIsNew"] as? String,
              let productPostImageCount = productDict["productPostImageCount"] as? Int,
              let productPostPhotoCount = productDict["productPostPhotoCount"] as? Int,
              let indexNumberOfProduct = productDict["indexNumberOfProduct"] as? Int,
              let messages = productDict["messages"] as? [message],
              let followers = productDict["followers"] as? [String]
        else {
            assertionFailure()
            return nil }
        
        
        self.init(
            store: store,
            productPostArticle: productPostArticle,
            productPostTitle: productPostTitle,
            productPostDescription: productPostDescription,
            productPostImageCount: productPostImageCount,
            productPostPrice: productPostPrice,
            productPostDiscont: productPostDiscont,
            productPostFinalPrice: productPostFinalPrice,
            productPostSex: productPostSex,
            productPostSeason: productPostSeason,
            productPostPublicationDate: productPostPublicationDate,
            productPostLikesCount: productPostLikesCount,
            productPostIsLiked: productPostIsLiked,
            productLikes: productLikes,
            productFollowers: followers,
            productPostViewsCount: productPostViewsCount,
            productPostPhotoCount: productPostPhotoCount,
            productPostIsNew: productPostIsNew,
            indexNumberOfProduct: indexNumberOfProduct,
            productPostArrayPhotos: productPostArrayPhotos,
            messages: messages
        )
    }
    
    var productDict: [String:Any]  {
        return [
        "productPostArticle": productPostArticle,
        "productPostArrayPhotos": productPostArrayPhotos,
        "productPostTitle": productPostTitle,
        "productPostDescription": productPostDescription,
        "productPostPrice": productPostPrice,
        "productPostFinalPrice": productPostFinalPrice,
        "productPostSex": productPostSex,
        "productPostSeason": productPostSeason,
        "productPostPublicationDate": productPostPublicationDate as Any,
        "productPostLikesCount": productPostLikesCount,
        "productLikes": likes,
        "productPostViewsCount": productPostViewsCount,
        "store": store,
        "productPostIsNew": productPostIsNew,
        "productPostImageCount": productPostImageCount,
        "productPostPhotoCount": productPostPhotoCount,
        "indexNumberOfProduct": indexNumberOfProduct,
        "messages": messages
        ]
    }
}
