//
//  Store.swift
//  Garment
//
//  Created by Максим Артемов on 10.09.2021.
//

import Foundation
import UIKit

protocol arrayStoresProtocol {
    init? (storeDict: [String: Any])
}

struct Store/*: Codable*/ {
    init(/*logo: UIImage,*/
         name: String,
         description: String,
         category: String?,
         url: String,
         instagram: String,
         vKontakte: String,
         odniklassniki: String,
         facebook: String,
         telephonNumber: String,
         whatsAppLink: String,
         whatsAppNumber: String,
         email: String,
         products: [Product]?,
         followers: [String]?) {
//        self.logo = logo
        self.name = name
        self.description = description
        self.category = category
        self.url = url
        self.instagram = instagram
        self.vKontakte = vKontakte
        self.odniklassniki = odniklassniki
        self.facebook = facebook
        self.telephonNumber = telephonNumber
        self.whatsAppLink = whatsAppLink
        self.whatsAppNumber = whatsAppNumber
        self.email = email
        self.products = []
        self.followers = []
             
             enum CodingKeys: String, CodingKey {
                 case name
                 case description
                 case category
                 case url
                 case instagram
                 case vKontakte
                 case odniklassniki
                 case facebook
                 case telephonNumber
                 case whatsAppLink
                 case whatsAppNumber
                 case email
                 case products
             }
    }
    
    enum StoreCategory: String {
        case shoes = "Обувь" //обувь
        case clothes = "Одежда" //одежда
        case sportWears = "Спортивная одежда" //спортивная одежда
        case swimsuits = "Купальники" //купальники
        case furCoats = "Шубы" //шубы
        
        static let allValues = [shoes, clothes, sportWears, swimsuits, furCoats]
        
        
    }
    
//    var logo: UIImage?
    var name: String
    var description: String
    
    var category: StoreCategory.RawValue?
    
    var url: String
    var instagram: String
    var vKontakte: String
    var odniklassniki: String
    var facebook: String
    
    var telephonNumber: String
    var whatsAppLink: String
    var whatsAppNumber: String
    var email: String
    var products: [Product]
    
    //    var workTime: String?
    
    var followers: [String]

    
    //    MARK: Firebase
    
    //    конструктор
    var storeDict: [String: Any] {
        return [
//            "logo": logo,
            "name": name,
            "description": description,
            "category": category,
            "url": url,
            "instagram": instagram,
            "vKontakte": vKontakte,
            "odniklassniki": odniklassniki,
            "facebook": facebook,
            "telephonNumber": telephonNumber,
            "whatsAppLink": whatsAppLink,
            "whatsAppNumber": whatsAppNumber,
            "email": email
        ]
    }
}


extension Store: arrayStoresProtocol {
    init?(storeDict: [String : Any]) {
        guard /*let logo = storeDict["logo"] as? UIImage,*/
              let name = storeDict["name"] as? String,
              let description = storeDict["description"] as? String,
              let category = storeDict["category"] as? String,
              let url = storeDict["url"] as? String,
              let instagram = storeDict["instagram"] as? String,
              let vKontakte = storeDict["vKontakte"] as? String,
              let odniklassniki = storeDict["odniklassniki"] as? String,
              let facebook = storeDict["facebook"] as? String,
              let telephonNumber = storeDict["telephonNumber"] as? String,
              let whatsAppLink = storeDict["whatsAppLink"] as? String,
              let whatsAppNumber = storeDict["whatsAppNumber"] as? String,
              let email = storeDict["email"] as? String

        else { return nil }
        
        self.init(/*logo: logo,*/
                  name: name,
                  description: description,
                  category: category,
                  url: url,
                  instagram: instagram,
                  vKontakte: vKontakte,
                  odniklassniki: odniklassniki,
                  facebook: facebook,
                  telephonNumber: telephonNumber,
                  whatsAppLink: whatsAppLink,
                  whatsAppNumber: whatsAppNumber,
                  email: email,
                  products: [],
                  followers: [])
    }
}
