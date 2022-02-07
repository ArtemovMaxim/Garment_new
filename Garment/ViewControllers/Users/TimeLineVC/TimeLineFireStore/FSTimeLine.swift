//
//  FSTimeLine.swift
//  Garment
//
//  Created by Максим Артемов on 22.10.2021.
//

import Foundation
import Firebase
import UIKit



struct FSTimeLine {
    
    
    enum fields: String {
        case article = "name"
        
//        //header
//        case productPostArticleLabel.text = ""
//        case productPostViewsLabel.text = ""
//        case productPostLikesCountLabel.text = ""
//        case productPostCommentsCountLabel.text = ""
//
//        //productPostImage
//
//
//        //productDescription
//        case.productPostDescriptionLabel.text = ""
//        case.productPostTitleLabel.text = ""
//
//        //footer
//        //productPropertys
//        case.productPostSexLabel.text = ""
//        case.productPostSeasonLabel.text = ""
//
//        //productPrice
//        case.productPostPriceLabel.text = ""
//        case.productPostDiscontLabel.text = ""
//        case.productPostFinalPriceLabel.text = ""
//
//        case.productPostPublicationDateLabel.text = ""
//
//        case.store.text = ""
    }
    
    let article = StoresViewController.productArticle
    var arrayProducts: [String] = []
    
//    func fillingFields( vc: TimeLineCollectionViewCell, product: Product, index: IndexPath)
//    {
//        
//        let ref = Firestore.firestore().collection("stores").document((Auth.auth().currentUser?.email)!).collection("products")
//                   
//        ref.getDocuments { (querySnapshot, error) in
//            guard let querySnapshot = querySnapshot else { return }
//            let data = querySnapshot.
//            
//          var index = 0
//            for document in querySnapshot.documents {
//                self.arrayProducts.append(document.data())
//            }
//        }
//        
//    }
}
