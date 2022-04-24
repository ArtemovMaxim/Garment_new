//
//  FSStoreSettings.swift
//  Garment
//
//  Created by Максим Артемов on 17.10.2021.
//

import Foundation
import Firebase

class StoreFireBase {
    
    // функция добавления Магазина в FireBase
    func addSettingsStoreToFireStore(name: String,
                                     description: String,
                                     category: String?,
                                     url: String,
                                     instagram: String,
                                     vk: String,
                                     ok: String,
                                     fb: String,
                                     telephon: String,
                                     waLink: String,
                                     numberWA: String,
                                     e_mail: String,
                                     workTime: String?,
                                     followers: [String]?,
                                     products: String?,
                                     productsCount: Int?) {
        
        // ссылки
        let db = Firestore.firestore()
        let idStore = (Firebase.Auth.auth().currentUser?.uid)!
        let currentUser = Auth.auth().currentUser?.email
        // создаем коллекция Магазинов
        let collect = db.collection("stores")
        // создаем документ с нозванием текущего Пользователя
        collect.document(currentUser!)
            .setData([
                "idStore": idStore,
                "name": name,
                "description": description,
                "category": category,
                "url": url,
                "instagram": instagram,
                "vKontakte": vk,
                "odniklassniki": ok,
                "facebook": fb,
                "telephonNumber": telephon,
                "whatsAppLink": waLink,
                "whatsAppNumber": numberWA,
                "email": AuthAccaunt.nameStore,
                "workTime": "",
                "followers": "",
                "productsCount": productsCount
            ], merge: true)
    }
}


