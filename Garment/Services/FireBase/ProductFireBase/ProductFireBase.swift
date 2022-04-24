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



class ProductFireBase {
    static var currentStringAnyArray: [String: Any] = [:]
    var currentCount = 0
    
    // функция загрузки фотографий
    
    static var compressionPhotos = 0.1
    
    static let email = (Auth.auth().currentUser?.email!)!
    
    //        выгружаем сгенерированный массив фото в ФС БД и добавлем ссылки на фото в карточке товара, возвращаем словарь ссылок
    var count = 0
    
    
    // получение массива ссылок из массива фотографий + добавление фотографий в Storege
    static var imageRefArray: [StorageReference] = []
    static var refArray: [StorageReference] = []
    static var URLarrayString: [String] = []
    var index = 0
    
    static func forInImageArray(images: [UIImage]) {
        
        _ = Auth.auth().currentUser?.email
        let metaData = StorageMetadata()
        let storageFirestore = Storage.storage().reference()
        let article = ProductViewController.productArticle
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser?.email
        let prodRef = db.collection("stores").document(currentUser!).collection("products").document(String(article))
        var img: Data?
        var index = 0
        var arr: [String: Any] = [:]
        
        for image in images {
            // получаем Data картинки
            if image != nil {
                img = image.jpegData(compressionQuality: ProductFireBase.compressionPhotos)
                // добавление в Firebase Storage
                metaData.contentType = "image/jpeg"
                let randomRef = String(arc4random())
                
                // создаем ссылку на фотографию
                let imageRef = storageFirestore.child("stores").child("\(ProductFireBase.email)").child("products").child("\(article)").child("\(article)_\(randomRef).jpeg")
//                 let imageRef = storageFirestore.child("stores/\(ProductFireBase.email)/products/\(article)/\(article)_\(randomRef).jpeg")
                
                // добавляем фотографию в FireBase Storage
                imageRef.putData(img!, metadata: metaData) { metaDat, error in
                    guard error == nil else { return }
                    
                    imageRef.downloadURL { url, error in
                        index += 1
                        arr[String(describing: index)] = url?.absoluteString
                        prodRef.setData(arr, merge: true)
                    }
                }
            }
        }
    }

//// добавление ссылок на фотографии в карточку Товара
//static func addURLtoProduct(stringsArray: [String]?, completionstringString: @escaping ([String: Any]) -> () ) {
//    var stringAny: [String: Any] = [:]
//    // переменная с индексом для порядкового номера Товара в карточке Товара
//    var ind = 1
//    _ = Auth.auth().currentUser?.email
//    _ = Firestore.firestore()
//
//    for string in stringsArray! {
//        stringAny["\(ind)"] = string
//        ind += 1
//    }
//    completionstringString(stringAny)
//}


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
