//
//  TimeLineCollectionViewCell.swift
//  Garment
//
//  Created by Максим Артемов on 11.09.2021.
//

import UIKit
import Foundation

class TimeLineCollectionViewCell: UICollectionViewCell {
    
    //vars
    
    //аутлеты
    @IBOutlet weak var header: UIStackView!
    @IBOutlet weak var productPostArticleLabel: UILabel!
    @IBOutlet weak var productPostViewsLabel: UILabel!
    @IBOutlet weak var productPostLikesCountLabel: UILabel!
    @IBOutlet weak var productPostCommentsCountLabel: UILabel!
    
    
    @IBOutlet weak var productDescription: UIStackView!
    @IBOutlet weak var productPostDescriptionLabel: UILabel!
    @IBOutlet weak var productPostTitleLabel: UILabel!
    
    
    @IBOutlet weak var footer: UIStackView!
    @IBOutlet weak var productPostSexLabel: UILabel!
    @IBOutlet weak var productPostSeasonLabel: UILabel!
    @IBOutlet weak var productPostPriceLabel: UILabel!
    @IBOutlet weak var productPostDiscontLabel: UILabel!
    @IBOutlet weak var productPostFinalPriceLabel: UILabel!
    @IBOutlet weak var productPostPublicationDateLabel: UILabel!
    @IBOutlet weak var productPostIsNewLabel: UILabel!
    
    
    @IBOutlet weak var buttons: UIStackView!
    @IBOutlet weak var followingButton: UIButton!

    @IBOutlet weak var buyButton: UIButton!
    
    
    @IBOutlet weak var albumCollection: UICollectionView!
    
    @IBOutlet weak var store: UILabel!
    
    @IBOutlet weak var heartImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // отображение или его отсутствие Сердечка в зависимости от авторизации
        if AuthAccaunt.authProfile == .store {
            self.heartImg.isHidden = true
        } else if AuthAccaunt.authProfile == .user {
            self.heartImg.isHidden = false
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
            recognizer.numberOfTapsRequired = 2
            self.addGestureRecognizer(recognizer)
        }
        
        let itemProductInTLCVC: Int = TimeLineCollectionViewController.indexPathItemTLCVC!
        // автоопределение Лайка
        if DataBase.allProductsDB[itemProductInTLCVC].likes.firstIndex(of: AuthAccaunt.nameStore) == nil {
            self.heartImg.image = UIImage(systemName: "heart")
        } else if DataBase.allProductsDB[itemProductInTLCVC].likes.firstIndex(of: AuthAccaunt.nameStore) != nil {
            self.heartImg.image = UIImage(systemName: "heart.fill")
        }
        
        // автоопределение Подписки
        if DataBase.allProductsDB[itemProductInTLCVC].followers.firstIndex(of: AuthAccaunt.nameStore) == nil {
            self.followingButton.setTitle("Подписаться", for: .normal)
        } else if DataBase.allProductsDB[itemProductInTLCVC].followers.firstIndex(of: AuthAccaunt.nameStore) != nil {
            self.followingButton.setTitle("Отписаться", for: .normal)
        }
    }
    
    @objc private func tap(sender: UITapGestureRecognizer) {
        // получаем номер Продукта из Ленты
        let itemProductInTLCVC: Int = TimeLineCollectionViewController.indexPathItemTLCVC!
        // постановка и удаление лайка с Вью
        // постановка лайка
        if DataBase.allProductsDB[itemProductInTLCVC].likes.firstIndex(of: AuthAccaunt.nameStore) == nil {
            self.heartImg.image = UIImage(systemName: "heart.fill")
            // добавляем к массиву Лайков новую запись
            DataBase.allProductsDB[itemProductInTLCVC].likes.append(AuthAccaunt.nameStore)
            // добавляем в поле Продукта увеличенное на +1 к количеству лайков
            DataBase.allProductsDB[itemProductInTLCVC].productPostLikesCount += 1
            let likes = DataBase.allProductsDB[itemProductInTLCVC].productPostLikesCount
            self.productPostLikesCountLabel.text = "Лайков: \(likes)"
            
        // удаление лайка
        } else {
            self.heartImg.image = UIImage(systemName: "heart")
            let delLikeIndex = DataBase.allProductsDB[itemProductInTLCVC].likes.firstIndex(of: AuthAccaunt.nameStore)
            DataBase.allProductsDB[itemProductInTLCVC].likes.remove(at: delLikeIndex!)
            DataBase.allProductsDB[itemProductInTLCVC].productPostLikesCount -= 1
            let likes = DataBase.allProductsDB[itemProductInTLCVC].productPostLikesCount
            self.productPostLikesCountLabel.text = "Лайков: \(likes)"
        }
    }
    
    @IBAction func followingButtonAction(_ sender: UIButton) {
        followStore()
    }
    
    // функция подписки на Магазин (надо доработать, чтобы добавлялось количство подписчиков в поле Продукта FireStore)
    func followStore() {
        let itemProductInTLCVC: Int = TimeLineCollectionViewController.indexPathItemTLCVC!
        
        // постановка лайка
        if DataBase.allProductsDB[itemProductInTLCVC].followers.firstIndex(of: AuthAccaunt.nameStore) == nil {
            DataBase.allProductsDB[itemProductInTLCVC].followers.append(AuthAccaunt.nameStore)
            self.followingButton.setTitle("Отписаться", for: .normal)
            
        // удаление лайка
        } else {
            let delLikeIndex = DataBase.allProductsDB[itemProductInTLCVC].followers.firstIndex(of: AuthAccaunt.nameStore)
            DataBase.allProductsDB[itemProductInTLCVC].followers.remove(at: delLikeIndex!)
            self.followingButton.setTitle("Подписаться", for: .normal)
        }
    }
    
    override func prepareForReuse() {
        productPostArticleLabel.text = ""
        productPostViewsLabel.text = ""
        productPostLikesCountLabel.text = ""
        productPostCommentsCountLabel.text = ""
        
        
        productPostDescriptionLabel.text = ""
        productPostTitleLabel.text = ""
        
        
        productPostSexLabel.text = ""
        productPostSeasonLabel.text = ""
        productPostPriceLabel.text = ""
        productPostDiscontLabel.text = ""
        productPostFinalPriceLabel.text = ""
        productPostPublicationDateLabel.text = ""
        productPostIsNewLabel.text = ""
        
        store.text = ""
        
        albumCollection.reloadInputViews()
    }
    
    //custom Function
    
    func allHeights() -> CGFloat {
        //высоты объектов
        let heightHeader = header.frame.height
        let heightProductDescription = productDescription.frame.height
        let heightFooter = footer.frame.height
        let heightButtons = buttons.frame.height
        let allHeights = heightHeader + heightProductDescription + heightFooter + heightButtons
        
        //высоты отступов
        let insets = header.spacing + productDescription.spacing + footer.spacing + buttons.spacing + 20 /*высота отступов над и под productPostImage*/
        
        return allHeights + insets
    }
    
    // создаем Алерт с полем для ввода Сообщения
    @IBAction func messageButtonAction(_ sender: UIButton) {
//        let alertController = UIAlertController(title: "Написать сообщение Магазину", message: "Текст сообщения", preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "Отправить", style: .default)
//        alertController.addAction(alertAction)
//        alertController.addTextField()
//
//        // добавлем Сообщение в поле Магазина
//        let message = alertController.textFields?.first?.text
//
//        let itemProductInTLCVC: Int = TimeLineCollectionViewController.indexPathItemTLCVC!
//
//        DataBase.allProductsDB[itemProductInTLCVC].messages[AuthAccaunt.nameStore] = message
        
        alertDelegate?.presentAlert()
    }
    
    var alertDelegate: alertProtocol?
}




protocol alertProtocol: AnyObject {
    func presentAlert()
}


