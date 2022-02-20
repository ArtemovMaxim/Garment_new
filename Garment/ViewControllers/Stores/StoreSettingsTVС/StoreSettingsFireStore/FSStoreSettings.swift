//
//  FSStoreSettings.swift
//  Garment
//
//  Created by Максим Артемов on 17.10.2021.
//

import Foundation
import Firebase

struct FSStoreSettings {
    
    func addSettingsStoreToFireStore(name: String, description: String, category: String, url: String, instagram: String, vk: String, ok: String, fb: String, telephon: String, waLink: String, numberWA: String, e_mail: String, workTime: String, followers: String, products: String, productsCount: Int?) {
        
        let db = Firestore.firestore()
        let idStore = (Firebase.Auth.auth().currentUser?.uid)!
        let currentUser = Auth.auth().currentUser?.email
        let collect = db.collection("stores") // создалась коллекция
        collect.document(currentUser!) // создался документ
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
                "email": e_mail,
                "workTime": "",
                "followers": "",
                "productsCount": productsCount
            ], merge: false)
    }
}


