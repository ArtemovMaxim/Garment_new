//
//  FSStores.swift
//  Garment
//
//  Created by Максим Артемов on 17.10.2021.
//

import Foundation
import UIKit
import Firebase

var urlURL: [String] = []
var photosCount: Int = 0
var currentProductArrayStrings: [String: String] = [:]



class FSStores {
    static var currentStringAnyArray: [String: Any] = [:]
    var currentCount = 0
    
    // функция загрузки фотографий
    
    static var compressionPhotos = 0.1
    
    static let email = (Auth.auth().currentUser?.email!)!
    
    //        выгружаем сгенерированный массив фото в ФС БД и добавлем ссылки на фото в карточке товара, возвращаем словарь ссылок
    var count = 0
    
    
    
    
    
    //        получение массива ссылок из массива фотографий + добавление фотографий в Storege
    static var imageRefArray: [URL] = []
    static var refArray: [StorageReference] = []
    static var URLarrayString: [String] = []
    let str = Storage.storage()
    let dbfs = Firestore.firestore()
    
    static func forInImageArray(images: [UIImage], completionImageRefArray: @escaping ([StorageReference]) -> (), completionRefs: @escaping ([StorageReference]) -> (), completionURLS: @escaping ([String]) -> () ) {
        
        
        _ = Auth.auth().currentUser?.email
        let metaData = StorageMetadata()
        let storageFirestore = Storage.storage().reference()
        let article = ProductViewController.productArticle
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser?.email
        _ = db.collection("stores").document(currentUser!).collection("products").document(String(FBDataBase.count + 1))
        
        for image in images {
            //                получаем Data картинки
            
            guard let img = image.jpegData(compressionQuality: FSStores.compressionPhotos) else { return }
            
            
            //            добавление в Firebase Storage
            metaData.contentType = "image/jpeg"
            let randomRef = String(arc4random())
            
            let imageRef = storageFirestore.child("stores").child("\(FSStores.email)").child("products").child("\(article)").child("\(article)_\(randomRef).jpeg")
            
            //            let imageRef = storageFirestore.child("stores/\(FSStores.email)/products/\(article)/\(article)_\(randomRef).jpeg")
            refArray.append(imageRef)
            completionRefs(refArray)

            
            
            imageRef.putData(img, metadata: metaData) { metaDat, error in
                guard error == nil else { return }
                
                imageRef.downloadURL { url, error in
                    guard error == nil else { return }
                    
                    URLarrayString.append(url!.absoluteString)
                    completionURLS(URLarrayString)
                }
            }
        }

        completionImageRefArray(refArray)
        
        addURLtoProduct(stringsArray: URLarrayString) { stringArray in
            currentStringAnyArray = stringArray
        }
    }
    
    
    
    static func addURLtoProduct(stringsArray: [String], completionstringString: @escaping ([String: Any]) -> ()) {
        var stringAny: [String: Any] = [:]
        var ind = 1
        _ = Auth.auth().currentUser?.email
        _ = Firestore.firestore()
        
        for string in stringsArray {
            stringAny["\(ind)"] = string
            ind += 1
        }
        completionstringString(stringAny)
    }
    
    
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
