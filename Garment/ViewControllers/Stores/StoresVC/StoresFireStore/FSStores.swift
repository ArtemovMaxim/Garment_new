//
//  FSStores.swift
//  Garment
//
//  Created by Максим Артемов on 17.10.2021.
//

import Foundation
import UIKit
import Firebase


class FSStores {
    
    var currentCount = 0
    
    // функция загрузки фотографий
    
    static var compressionPhotos = 0.1
    
    static let email = (Auth.auth().currentUser?.email!)!
 
    //        выгружаем сгенерированный массив фото в ФС БД и добавлем ссылки на фото в карточке товара, возвращаем словарь ссылок
    var count = 0
    static var currentProductArrayStrings: [String: String] = [:]
    static var photosCount: Int = 0
    static var urlURL: [URL] = []
    
    static func uploadPhoto(images: [UIImage], completion: @escaping ([String: String]) -> (), completion1: @escaping (Int) -> (), urlArray: ([URL]) -> () ) {

        let article = StoresViewController.productArticle
        var urlPhoto = ""
        var indexImage = 0
        
        
        let currentUser = (Auth.auth().currentUser?.email)!
        
        let storageFirestore = Storage.storage().reference()
        let db = Firestore.firestore()
        let metaData = StorageMetadata()
        
        let refProducts = db.collection("stores").document(currentUser).collection("products").document(String(FBDataBase.count + 1))
        
        for index in images {
            guard let imageData = index.jpegData(compressionQuality: FSStores.compressionPhotos) else { return }
            
            metaData.contentType = "image/jpeg"
            
            let randomRef = (Auth.auth().currentUser!.uid) + "_" + (String(arc4random()))
            let imageRef = storageFirestore.child("stores/" + FSStores.email + "/products/" + "\(article)/" + "\(randomRef)" + ".jpeg")
            
            imageRef.putData(imageData, metadata: metaData) { (metadata, error) in
                guard metadata != nil else { return }
                
                imageRef.downloadURL { (url, error) in
                    guard let url = url else { return }
                    urlPhoto = url.absoluteString
                    FSStores.currentProductArrayStrings["URL \(indexImage + 1)"] = urlPhoto
                    FSStores.urlURL.append(url)
                    FSStores.photosCount += 1
                    completion1(FSStores.photosCount)
                    
                    indexImage += 1
                    refProducts.setData(currentProductArrayStrings, merge: true, completion: nil)
                }
            }
        }
        completion(currentProductArrayStrings)
        urlArray(FSStores.urlURL)
    }
    
//    func addingToArrayStrings() {
//        var indexImage = 0
//        
//        let urlPhoto =
//        
//        array["URL \(indexImage + 1)"] = urlPhoto
//        indexImage += 1
//        refProducts.setData(FSStores.arrayStrings, merge: true, completion: nil)
//    }
    
    // 2. получаем общее количество товаров
    static func getCurrentCountProducts(completion: @escaping (Int) -> ()) {
        var count = 0
        Firestore.firestore().collection("stores")
            .document((Auth.auth().currentUser?.email)!)
            .collection("products")
            .getDocuments() { (documents, error) in
                guard error == nil else { return }
                guard documents != nil else { return }
                for document in documents!.documents {
                    count += 1
                }
                completion(count)
            }
    }
}
