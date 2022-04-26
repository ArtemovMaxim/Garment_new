//
//  User.swift
//  Garment
//
//  Created by Максим Артемов on 10.09.2021.
//

import Foundation

// протокол
protocol arrayUsersProtocol {
    init? (userDict: [String: Any])
}


struct User/*: Codable*/ {
    internal init(UserFirstName: String,
                  UserLastName: String,
                  UserAge: String,
                  UserSex: Product.Sex.RawValue,
                  userSubscribtions: [Store]) {
        self.userFirstName = UserFirstName
        self.userLastName = UserLastName
        self.userAge = UserAge
        self.userSex = UserSex
        self.userSubscribtions = userSubscribtions
    }
    
    
    //параметры пользователя
    var userFirstName: String = ""
    var userLastName: String = ""
    var userAge: String = ""
    var userSex: Product.Sex.RawValue?
    
    //подписки на магазины
    var userSubscribtions: [Store?]
}


// расширение
extension User: arrayUsersProtocol {
    
    init? (userDict: [String : Any]) {
        guard let userFirstName = userDict["UserFirstName"] as? String,
              let userLastName = userDict["UserLastName"] as? String,
              let userAge = userDict["UserAge"] as? String,
              let userSex = userDict["UserSex"] as? String,
              let userSubscribtions = userDict["userSubscribtions"] as? [Store]

        else { return nil}
        self.init (
            UserFirstName: userFirstName,
            UserLastName: userLastName,
            UserAge: userAge,
            UserSex: userSex,
            userSubscribtions: userSubscribtions
        )
    }
    
    var userDict: [String: Any] {
        return [
            "userFirstName": userFirstName,
            "userLastName": userLastName,
            "userAge": userAge,
            "userSex": userSex,
            "userSubscribtions": userSubscribtions
        ]
    }
}
