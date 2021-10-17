//
//  FSStores.swift
//  Garment
//
//  Created by Максим Артемов on 17.10.2021.
//

import Foundation
import Firebase

struct FSStores {
    
    func uplodPostToTimeLineFireStore(
        StoresVCArticleField: String,
        //        productPostArrayPhotos: String,
        StoresVCProductTitleField: String,
        StoresVCDiscriptionField: String,
        StoresVCPriceField: String,
        StoresVCDiscountField: String,
        StoresVCFinalPriceField: String,
        //        choiceSex: String,
        //        choiceSeason: String,
        //        generateDatePosting: String,
        productPostLikesCount: Int,
        productPostIsLiked: Bool,
        productPostViewsCount: Int,
        //        productPostComments: String,
        productPostCommentsCount: Int
        //        productPostIsNew: String,
        //        productPostImageCount: String)
    )
    {
        
        let db = Firestore.firestore()
        let idStore = (Firebase.Auth.auth().currentUser?.uid)!
        let currentCollection = db.collection("stores")
        
        let products = currentCollection.document(idStore)
            .collection("products")
        
        products.document("products").setData([
            "productPostArticle": StoresVCArticleField,
            "productPostArrayPhotos": "",
            //                "productPostFirstImage": StoreVСProductImage,
            "productPostTitle": StoresVCProductTitleField,
            "productPostDescription": StoresVCDiscriptionField,
            "productPostPrice": StoresVCPriceField,
            "productPostDiscont": StoresVCDiscountField,
            "productPostFinalPrice" : StoresVCFinalPriceField,
            //                "productPostSex": choiceSex,
            //                "productPostSeason": choiceSeason,
            //                "productPostPublicationDate": generateDatePosting,
            "productPostLikesCount": "",
            "productPostIsLiked": "",
            "productPostViewsCount": "",
            "productPostComments": "",
            "productPostCommentsCount": ""
            //                "productPostIsNew": productPostIsNew,
            //                "productPostImageCount": productPostImageCount
        ], merge: true)
        
        products.document("products").collection("продукты магазина").document().setData([
            "наименование товара": "джинсы",
            "размер": "37",
            "сезон": "осень"
        ])
        
    }
    
}
