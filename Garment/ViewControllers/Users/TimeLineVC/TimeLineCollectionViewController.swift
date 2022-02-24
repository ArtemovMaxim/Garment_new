//
//  TimeLineCollectionViewController.swift
//  Garment
//
//  Created by Максим Артемов on 11.09.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseMLModelDownloader

enum Ident: String {
    case reuseIdentifier = "Cell"
    case reuseIdentifierAlbum = "PhotoAlbumCell"
}

class TimeLineCollectionViewController: UICollectionViewController {
    
    //индекс для передачи item в albumCollectionView
    static var item: Int = 0
    
    var allPrdcsArr: [Product] = []
    
    static var prodArray: [Product] = []
    
    static var allProd: [Product] = []
    
    var fsArrayStores: [Store] = []
    
    var dataBse = FBDataBase()
    
    //аутлеты
    @IBOutlet var globalCollectionView: PhotoAlbumCollectionViewCell!
    
    func loadind() {
//        FBDataBase.creatUserTimeLineProducts { all in
//            TimeLineCollectionViewController.allProd = all
////            self.collectionView.reloadData()
//        }
        
        TimeLineCollectionViewController.allProd = FBDataBase.allProdArray

    }
    
    override func loadView() {
        super.loadView()
            switch AuthAccaunt.authProfile {
            case .store:
//                FBDataBase.creatUserTimeLineProducts { prodArray in
//                    TimeLineCollectionViewController.prodArray = prodArray

//                }
                print("TLCVC все продукты count: \(TimeLineCollectionViewController.prodArray.count)")

//                FBDataBase.creatDB { prodArray in
//                    TimeLineCollectionViewController.prodArray = prodArray
//                    print("TLCVC все продукты count: \(TimeLineCollectionViewController.prodArray.count)")
//                }
                
            case .user:
                loadind()
                
            case .nonAuth:
                FBDataBase.creatUserTimeLineProducts { allProducts in
                    TimeLineCollectionViewController.allProd = allProducts
                }
            }
    }

    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch AuthAccaunt.authProfile {
        case .store:
            print("Количество Айтемс Магазины: \(self.allPrdcsArr.count)")
            return self.allPrdcsArr.count
        case .user:
            print("Количество Айтемс Покупатели: \(self.allPrdcsArr.count)")
            return self.allPrdcsArr.count
        case .nonAuth:
            print("Количество Айтемс Нон: \(self.allPrdcsArr.count)")
            return self.allPrdcsArr.count
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch AuthAccaunt.authProfile {
            
        case .store:
            return generateStoreCell(collectionView, cellForItemAt: indexPath, nameStore: AuthAccaunt.nameStore)
            
        case .user:
//            prodArray = DataBase().generateArray(name: AuthAccaunt.nameStore)
            return generateUserCell(collectionView, cellForItemAt: indexPath, nameStore: AuthAccaunt.nameStore)
            
        case .nonAuth:
//            prodArray = DataBase().generateArray(name: AuthAccaunt.nameStore)
            return generateNonAuthCell(collectionView, cellForItemAt: indexPath, nameStore: AuthAccaunt.nameStore)
            
        }
    }
    
    
    func generateStoreCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, nameStore: String) -> UICollectionViewCell {
        
        
        TimeLineCollectionViewController.item = indexPath.item
        print("TLCVC, item: \(TimeLineCollectionViewController.item)")
        
        let cellStore = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifier.rawValue, for: indexPath) as! TimeLineCollectionViewCell
        
        cellStore.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //отключение автомата
        cellStore.header.translatesAutoresizingMaskIntoConstraints = false
        cellStore.albumCollection.translatesAutoresizingMaskIntoConstraints = false
        cellStore.productDescription.translatesAutoresizingMaskIntoConstraints = false
        cellStore.footer.translatesAutoresizingMaskIntoConstraints = false
        cellStore.buttons.translatesAutoresizingMaskIntoConstraints = false
        cellStore.albumCollection.translatesAutoresizingMaskIntoConstraints = false
        
        //констрейнты
        NSLayoutConstraint.activate([
            
            //header
            cellStore.header.topAnchor.constraint(equalTo: cellStore.contentView.topAnchor, constant: 10),
            cellStore.header.trailingAnchor.constraint(equalTo: cellStore.contentView.trailingAnchor, constant: 10),
            cellStore.header.leadingAnchor.constraint(equalTo: cellStore.contentView.leadingAnchor, constant: 10),
            
            //productPostImage
            cellStore.albumCollection.topAnchor.constraint(equalTo: cellStore.header.bottomAnchor, constant: 10),
            cellStore.albumCollection.trailingAnchor.constraint(equalTo: cellStore.contentView.trailingAnchor, constant: 10),
            cellStore.albumCollection.leadingAnchor.constraint(equalTo: cellStore.contentView.leadingAnchor, constant: 10),
            
            cellStore.albumCollection.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - cellStore.allHeights()),
            
            //productDescription
            cellStore.productDescription.topAnchor.constraint(equalTo: cellStore.albumCollection.bottomAnchor, constant: 10),
            cellStore.productDescription.trailingAnchor.constraint(equalTo: cellStore.contentView.trailingAnchor, constant: 10),
            cellStore.productDescription.leadingAnchor.constraint(equalTo: cellStore.contentView.leadingAnchor, constant: 10),
            
            //footer
            cellStore.footer.topAnchor.constraint(equalTo: cellStore.productDescription.bottomAnchor, constant: 10),
            cellStore.footer.trailingAnchor.constraint(equalTo: cellStore.contentView.trailingAnchor, constant: 10),
            cellStore.footer.leadingAnchor.constraint(equalTo: cellStore.contentView.leadingAnchor, constant: 10),
            
            //buttons
            cellStore.buttons.topAnchor.constraint(equalTo: cellStore.footer.bottomAnchor, constant: 10),
            cellStore.buttons.trailingAnchor.constraint(equalTo: cellStore.contentView.trailingAnchor, constant: 10),
            cellStore.buttons.leadingAnchor.constraint(equalTo: cellStore.contentView.leadingAnchor, constant: 10),
            
            //ScrollView aka productPostImage
            cellStore.albumCollection.topAnchor.constraint(equalTo: cellStore.header.bottomAnchor, constant: 10),
            cellStore.albumCollection.bottomAnchor.constraint(equalTo: cellStore.productDescription.topAnchor, constant: 10),
            cellStore.albumCollection.leadingAnchor.constraint(equalTo: cellStore.contentView.leadingAnchor, constant: 10),
            cellStore.albumCollection.trailingAnchor.constraint(equalTo: cellStore.contentView.trailingAnchor, constant: 10)
        ])
        
        // Configure the cell
        
        
        //header
        cellStore.productPostArticleLabel.text = ""
        cellStore.productPostViewsLabel.text = ""
        cellStore.productPostLikesCountLabel.text = ""
        cellStore.productPostCommentsCountLabel.text = ""
        
        //productPostImage
        
        
        //productDescription
        cellStore.productPostDescriptionLabel.text = ""
        cellStore.productPostTitleLabel.text = ""
        
        //footer
        //productPropertys
        cellStore.productPostSexLabel.text = ""
        cellStore.productPostSeasonLabel.text = ""
        
        //productPrice
        cellStore.productPostPriceLabel.text = ""
        cellStore.productPostDiscontLabel.text = ""
        cellStore.productPostFinalPriceLabel.text = ""
        
        cellStore.productPostPublicationDateLabel.text = ""
        
        cellStore.store.text = ""

        
        
        
        //header
        cellStore.productPostArticleLabel.text = "Артикул: " + String(TimeLineCollectionViewController.prodArray[indexPath.item].productPostArticle)
        
        cellStore.productPostViewsLabel.text = "Просмотров: " + String(TimeLineCollectionViewController.prodArray[indexPath.item].productPostViewsCount)
        cellStore.productPostLikesCountLabel.text = "Лайков: " + String(TimeLineCollectionViewController.prodArray[indexPath.item].productPostLikesCount)
        //        cellStore.productPostCommentsCountLabel.text = "Комментариев: " + String(arrayStores[indexPath.item].productPostCommentsCount)
        
        
        //productDescription
        cellStore.productPostDescriptionLabel.text = TimeLineCollectionViewController.prodArray[indexPath.item].productPostDescription
        cellStore.productPostTitleLabel.text = TimeLineCollectionViewController.prodArray[indexPath.item].productPostTitle
        
        //footer
        //        productPropertys
        cellStore.productPostSexLabel.text = "Пол: " + TimeLineCollectionViewController.prodArray[indexPath.item].productPostSex
        cellStore.productPostSeasonLabel.text = "Сезон: " + TimeLineCollectionViewController.prodArray[indexPath.item].productPostSeason
        cellStore.productPostIsNewLabel.text = "Новизна: " + TimeLineCollectionViewController.prodArray[indexPath.item].productPostIsNew
        
        //productPrice
        cellStore.productPostPriceLabel.text = "Цена: " + String(TimeLineCollectionViewController.prodArray[indexPath.item].productPostPrice) + " руб."
        cellStore.productPostDiscontLabel.text = "Скидка: " + "\(TimeLineCollectionViewController.prodArray[indexPath.item].productPostDiscont)" + " %"
        cellStore.productPostFinalPriceLabel.text = "Итого: " + "\(TimeLineCollectionViewController.prodArray[indexPath.item].productPostFinalPrice)" + " руб."
        
        cellStore.productPostPublicationDateLabel.text = "Дата публикации"
        cellStore.store.text = "Магазин: " + "\(nameStore)"
        
        return cellStore
        
    }
    
    func generateUserCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, nameStore: String) -> UICollectionViewCell {
        TimeLineCollectionViewController.item = indexPath.item
        
        let cellUser = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifier.rawValue, for: indexPath) as! TimeLineCollectionViewCell
        cellUser.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //отключение автомата
        cellUser.header.translatesAutoresizingMaskIntoConstraints = false
        cellUser.albumCollection.translatesAutoresizingMaskIntoConstraints = false
        cellUser.productDescription.translatesAutoresizingMaskIntoConstraints = false
        cellUser.footer.translatesAutoresizingMaskIntoConstraints = false
        cellUser.buttons.translatesAutoresizingMaskIntoConstraints = false
        cellUser.albumCollection.translatesAutoresizingMaskIntoConstraints = false
        
        //констрейнты
        NSLayoutConstraint.activate([
            
            //header
            cellUser.header.topAnchor.constraint(equalTo: cellUser.contentView.topAnchor, constant: 10),
            cellUser.header.trailingAnchor.constraint(equalTo: cellUser.contentView.trailingAnchor, constant: 10),
            cellUser.header.leadingAnchor.constraint(equalTo: cellUser.contentView.leadingAnchor, constant: 10),
            
            //productPostImage
            cellUser.albumCollection.topAnchor.constraint(equalTo: cellUser.header.bottomAnchor, constant: 10),
            cellUser.albumCollection.trailingAnchor.constraint(equalTo: cellUser.contentView.trailingAnchor, constant: 10),
            cellUser.albumCollection.leadingAnchor.constraint(equalTo: cellUser.contentView.leadingAnchor, constant: 10),
            
            cellUser.albumCollection.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - cellUser.allHeights()),
            
            //productDescription
            cellUser.productDescription.topAnchor.constraint(equalTo: cellUser.albumCollection.bottomAnchor, constant: 10),
            cellUser.productDescription.trailingAnchor.constraint(equalTo: cellUser.contentView.trailingAnchor, constant: 10),
            cellUser.productDescription.leadingAnchor.constraint(equalTo: cellUser.contentView.leadingAnchor, constant: 10),
            
            //footer
            cellUser.footer.topAnchor.constraint(equalTo: cellUser.productDescription.bottomAnchor, constant: 10),
            cellUser.footer.trailingAnchor.constraint(equalTo: cellUser.contentView.trailingAnchor, constant: 10),
            cellUser.footer.leadingAnchor.constraint(equalTo: cellUser.contentView.leadingAnchor, constant: 10),
            
            //buttons
            cellUser.buttons.topAnchor.constraint(equalTo: cellUser.footer.bottomAnchor, constant: 10),
            cellUser.buttons.trailingAnchor.constraint(equalTo: cellUser.contentView.trailingAnchor, constant: 10),
            cellUser.buttons.leadingAnchor.constraint(equalTo: cellUser.contentView.leadingAnchor, constant: 10),
            
            //ScrollView aka productPostImage
            cellUser.albumCollection.topAnchor.constraint(equalTo: cellUser.header.bottomAnchor, constant: 10),
            cellUser.albumCollection.bottomAnchor.constraint(equalTo: cellUser.productDescription.topAnchor, constant: 10),
            cellUser.albumCollection.leadingAnchor.constraint(equalTo: cellUser.contentView.leadingAnchor, constant: 10),
            cellUser.albumCollection.trailingAnchor.constraint(equalTo: cellUser.contentView.trailingAnchor, constant: 10)
        ])
        
        // Configure the cell
        
        
        //header
        cellUser.productPostArticleLabel.text = ""
        cellUser.productPostViewsLabel.text = ""
        cellUser.productPostLikesCountLabel.text = ""
        cellUser.productPostCommentsCountLabel.text = ""
        
        cellUser.productPostDescriptionLabel.text = ""
        cellUser.productPostTitleLabel.text = ""
        
        //footer
        //productPropertys
        cellUser.productPostSexLabel.text = ""
        cellUser.productPostSeasonLabel.text = ""
        
        //productPrice
        cellUser.productPostPriceLabel.text = ""
        cellUser.productPostDiscontLabel.text = ""
        cellUser.productPostFinalPriceLabel.text = ""
        
        cellUser.productPostPublicationDateLabel.text = ""
        
        
        //header
        cellUser.productPostArticleLabel.text = "Артикул: " + TimeLineCollectionViewController.allProd[indexPath.item].productPostArticle
        cellUser.productPostViewsLabel.text = "Просмотров: " + String(TimeLineCollectionViewController.allProd[indexPath.item].productPostViewsCount)
        cellUser.productPostLikesCountLabel.text = "Лайков: " + String(TimeLineCollectionViewController.allProd[indexPath.item].productPostLikesCount)
        //        cellUser.productPostCommentsCountLabel.text = "Комментариев: " + String(DataBase.productsDb[indexPath.item].productPostCommentsCount)
        
        
        //productDescription
        cellUser.productPostDescriptionLabel.text = TimeLineCollectionViewController.allProd[indexPath.item].productPostDescription
        cellUser.productPostTitleLabel.text = TimeLineCollectionViewController.allProd[indexPath.item].productPostTitle
        
        //footer
        //productPropertys
        cellUser.productPostSexLabel.text = "Пол: " + TimeLineCollectionViewController.allProd[indexPath.item].productPostSex
        cellUser.productPostSeasonLabel.text = "Сезон: " + TimeLineCollectionViewController.allProd[indexPath.item].productPostSeason
        cellUser.productPostIsNewLabel.text = "Новизна: " + TimeLineCollectionViewController.allProd[indexPath.item].productPostIsNew
        
        //productPrice
        cellUser.productPostPriceLabel.text = "Цена: " + String(TimeLineCollectionViewController.allProd[indexPath.item].productPostPrice) + " руб."
        cellUser.productPostDiscontLabel.text = "Скидка: " + "\(TimeLineCollectionViewController.allProd[indexPath.item].productPostDiscont)" + " %"
        cellUser.productPostFinalPriceLabel.text = "Итого: " + "\(TimeLineCollectionViewController.allProd[indexPath.item].productPostFinalPrice)" + " руб."
        
        cellUser.productPostPublicationDateLabel.text = "Дата публикации"
        cellUser.store.text = "Магазин: " + "\(TimeLineCollectionViewController.allProd[indexPath.item].store)"
        
        return cellUser
        
    }
    
    func generateNonAuthCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, nameStore: String) -> UICollectionViewCell {
        TimeLineCollectionViewController.item = indexPath.item
        
        let cellNonAuth = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifier.rawValue, for: indexPath) as! TimeLineCollectionViewCell
        cellNonAuth.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //отключение автомата
        cellNonAuth.header.translatesAutoresizingMaskIntoConstraints = false
        cellNonAuth.albumCollection.translatesAutoresizingMaskIntoConstraints = false
        cellNonAuth.productDescription.translatesAutoresizingMaskIntoConstraints = false
        cellNonAuth.footer.translatesAutoresizingMaskIntoConstraints = false
        cellNonAuth.buttons.translatesAutoresizingMaskIntoConstraints = false
        cellNonAuth.albumCollection.translatesAutoresizingMaskIntoConstraints = false
        
        //констрейнты
        NSLayoutConstraint.activate([
            
            //header
            cellNonAuth.header.topAnchor.constraint(equalTo: cellNonAuth.contentView.topAnchor, constant: 10),
            cellNonAuth.header.trailingAnchor.constraint(equalTo: cellNonAuth.contentView.trailingAnchor, constant: 10),
            cellNonAuth.header.leadingAnchor.constraint(equalTo: cellNonAuth.contentView.leadingAnchor, constant: 10),
            
            //productPostImage
            cellNonAuth.albumCollection.topAnchor.constraint(equalTo: cellNonAuth.header.bottomAnchor, constant: 10),
            cellNonAuth.albumCollection.trailingAnchor.constraint(equalTo: cellNonAuth.contentView.trailingAnchor, constant: 10),
            cellNonAuth.albumCollection.leadingAnchor.constraint(equalTo: cellNonAuth.contentView.leadingAnchor, constant: 10),
            
            cellNonAuth.albumCollection.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - cellNonAuth.allHeights()),
            
            //productDescription
            cellNonAuth.productDescription.topAnchor.constraint(equalTo: cellNonAuth.albumCollection.bottomAnchor, constant: 10),
            cellNonAuth.productDescription.trailingAnchor.constraint(equalTo: cellNonAuth.contentView.trailingAnchor, constant: 10),
            cellNonAuth.productDescription.leadingAnchor.constraint(equalTo: cellNonAuth.contentView.leadingAnchor, constant: 10),
            
            //footer
            cellNonAuth.footer.topAnchor.constraint(equalTo: cellNonAuth.productDescription.bottomAnchor, constant: 10),
            cellNonAuth.footer.trailingAnchor.constraint(equalTo: cellNonAuth.contentView.trailingAnchor, constant: 10),
            cellNonAuth.footer.leadingAnchor.constraint(equalTo: cellNonAuth.contentView.leadingAnchor, constant: 10),
            
            //buttons
            cellNonAuth.buttons.topAnchor.constraint(equalTo: cellNonAuth.footer.bottomAnchor, constant: 10),
            cellNonAuth.buttons.trailingAnchor.constraint(equalTo: cellNonAuth.contentView.trailingAnchor, constant: 10),
            cellNonAuth.buttons.leadingAnchor.constraint(equalTo: cellNonAuth.contentView.leadingAnchor, constant: 10),
            
            //ScrollView aka productPostImage
            cellNonAuth.albumCollection.topAnchor.constraint(equalTo: cellNonAuth.header.bottomAnchor, constant: 10),
            cellNonAuth.albumCollection.bottomAnchor.constraint(equalTo: cellNonAuth.productDescription.topAnchor, constant: 10),
            cellNonAuth.albumCollection.leadingAnchor.constraint(equalTo: cellNonAuth.contentView.leadingAnchor, constant: 10),
            cellNonAuth.albumCollection.trailingAnchor.constraint(equalTo: cellNonAuth.contentView.trailingAnchor, constant: 10)
        ])
        
        // Configure the cell
        
        
        //header
        cellNonAuth.productPostArticleLabel.text = ""
        cellNonAuth.productPostViewsLabel.text = ""
        cellNonAuth.productPostLikesCountLabel.text = ""
        cellNonAuth.productPostCommentsCountLabel.text = ""
        
        cellNonAuth.productPostDescriptionLabel.text = ""
        cellNonAuth.productPostTitleLabel.text = ""
        
        //footer
        //productPropertys
        cellNonAuth.productPostSexLabel.text = ""
        cellNonAuth.productPostSeasonLabel.text = ""
        
        //productPrice
        cellNonAuth.productPostPriceLabel.text = ""
        cellNonAuth.productPostDiscontLabel.text = ""
        cellNonAuth.productPostFinalPriceLabel.text = ""
        
        cellNonAuth.productPostPublicationDateLabel.text = ""
        
        
        //header
        cellNonAuth.productPostArticleLabel.text = "Артикул: " + DataBase.productsDb[indexPath.item].productPostArticle
        cellNonAuth.productPostViewsLabel.text = "Просмотров: " + String(DataBase.productsDb[indexPath.item].productPostViewsCount)
        cellNonAuth.productPostLikesCountLabel.text = "Лайков: " + String(DataBase.productsDb[indexPath.item].productPostLikesCount)
        //        cellNonAuth.productPostCommentsCountLabel.text = "Комментариев: " + String(DataBase.productsDb[indexPath.item].productPostCommentsCount)
        
        
        //productDescription
        cellNonAuth.productPostDescriptionLabel.text = DataBase.productsDb[indexPath.item].productPostDescription
        cellNonAuth.productPostTitleLabel.text = DataBase.productsDb[indexPath.item].productPostTitle
        
        //footer
        //productPropertys
        cellNonAuth.productPostSexLabel.text = "Пол: " + DataBase.productsDb[indexPath.item].productPostSex
        cellNonAuth.productPostSeasonLabel.text = "Сезон: " + DataBase.productsDb[indexPath.item].productPostSeason
        cellNonAuth.productPostIsNewLabel.text = "Новизна: " + DataBase.productsDb[indexPath.item].productPostIsNew
        
        //productPrice
        cellNonAuth.productPostPriceLabel.text = "Цена: " + String(DataBase.productsDb[indexPath.item].productPostPrice) + " руб."
        cellNonAuth.productPostDiscontLabel.text = "Скидка: " + "\(DataBase.productsDb[indexPath.item].productPostDiscont)" + " %"
        cellNonAuth.productPostFinalPriceLabel.text = "Итого: " + "\(DataBase.productsDb[indexPath.item].productPostFinalPrice)" + " руб."
        
        cellNonAuth.productPostPublicationDateLabel.text = "Дата публикации"
        cellNonAuth.store.text = "Магазин: " + "\(nameStore)"
        
        return cellNonAuth
    }
}
