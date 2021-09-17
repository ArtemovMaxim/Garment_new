//
//  Product.swift
//  Garment
//
//  Created by Максим Артемов on 10.09.2021.
//

import Foundation
import UIKit

struct ProductPost {
    internal init(productPostArticle: String, productPostImage: UIImage, productPostTitle: String? = nil, productPostDescription: String? = nil, productPostPrice: Float, productPostDiscont: Float? = nil, productPostSex: ProductPost.Sex? = nil, productPostSeason: ProductPost.Season? = nil, productPostPublicationDate: Date? = nil, productPostLikesCount: Int, productPostIsLiked: Bool, productPostViewsCount: Int, productPostComments: [ProductPost.ProductPostCommentsArray]? = nil, productPostCommentsCount: Int, productPostIsNew: ProductPost.New) {
        self.productPostArticle = productPostArticle
        self.productPostImage = productPostImage
        self.productPostTitle = productPostTitle
        self.productPostDescription = productPostDescription
        self.productPostPrice = productPostPrice
        self.productPostDiscont = productPostDiscont
        self.productPostSex = productPostSex
        self.productPostSeason = productPostSeason
        self.productPostPublicationDate = productPostPublicationDate
        self.productPostLikesCount = productPostLikesCount
        self.productPostIsLiked = productPostIsLiked
        self.productPostViewsCount = productPostViewsCount
        self.productPostComments = productPostComments
        self.productPostCommentsCount = productPostCommentsCount
        self.productPostIsNew = productPostIsNew
    }
    

    
    
    //артукул
    var productPostArticle: String
    
    //описание товара
    var productPostImage: UIImage
    var productPostTitle: String?
    var productPostDescription: String?
    
    //стоимость товара
    var productPostPrice: Float
    var productPostDiscont: Float?
    var productPostFinalPrice: Float {
        if let productPostDiscont = productPostDiscont {
            return (productPostPrice - (productPostPrice / 100) * productPostDiscont)
        } else { return productPostPrice }
    }
    
    //параметры товара
    var productPostSex: Sex?
    var productPostSeason: Season?
    
    //параметры поста
    var productPostPublicationDate: Date?
    var productPostLikesCount: Int
    var productPostIsLiked: Bool
    var productPostViewsCount: Int
    
    //параметры комментариев
    var productPostComments: [ProductPostCommentsArray]?
    var productPostCommentsCount: Int
    
    //новизна товара
    var productPostIsNew: New
    
    //инициализаторы
    
    
    //функция добвления нового товара
    func addNewProduct() {
        
    }
    
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
    
    //комментарии
    struct ProductPostCommentsArray {
        var user: User
        var comment: String
        var productCommentDate: Date
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




