//
//  User.swift
//  Garment
//
//  Created by Максим Артемов on 10.09.2021.
//

import Foundation

struct User {
    
//параметры пользователя
    var UserFirstName: String?
    var UserLastName: String?
    var UserAge: Int?
    var UserSex: Product.Sex?
    
//подписки на магазины
    var userSubscribtions: [Store]
    
//история лайков и комментариев
    var userLikesHistory: [UserLikesHistoryArray]
}

struct UserLikesHistoryArray {
    
}
