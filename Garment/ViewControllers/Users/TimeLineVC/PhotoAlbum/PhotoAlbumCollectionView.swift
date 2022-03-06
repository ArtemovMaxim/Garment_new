//
//  PhotoAlbumCollectionView.swift
//  Garment
//
//  Created by Максим Артемов on 02.10.2021.
//

import UIKit

class PhotoAlbumCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //    like image
    @IBOutlet weak var heartImage: UIImageView!
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionHeight = self.layer.bounds.height
        let collectionWidth = self.layer.bounds.width
        
        let cellSize = CGSize(width: collectionWidth, height: collectionHeight)
        
        return cellSize
    }
    
    
    var itemProductInTLCVC = TimeLineCollectionViewController.indexPathItemTLCVC
    var indexPathTLCVC = TimeLineCollectionViewController.indexPathTLCVC
    var countImages: Int = 0
    
    
    // вычисление количества фотографий у товара
    func countPhotoInProduct(indProductInTLCVC: Int, completion: @escaping (Product?, Error?, Int) -> ()) {
        
        switch AuthAccaunt.authProfile {
        case .user:
            let count = TimeLineCollectionViewController.allProductsArray[indProductInTLCVC].productPostPhotoCount
            let currentProduct = TimeLineCollectionViewController.allProductsArray[indProductInTLCVC]
            completion(currentProduct, nil, count)
            
        case .store:
            //            получаем все товары всех магазинов
            let countPhotos = TimeLineCollectionViewController.allProductsArray[indProductInTLCVC].productPostPhotoCount
            let currentProduct = TimeLineCollectionViewController.allProductsArray[indProductInTLCVC]
            completion(currentProduct, nil, countPhotos)
            
        case .nonAuth:
            let countPhotos = TimeLineCollectionViewController.allProductsArray[indProductInTLCVC].productPostPhotoCount
            let currentProduct = TimeLineCollectionViewController.allProductsArray[indProductInTLCVC]
            completion(currentProduct, nil, countPhotos)
        }
    }
    
    var arrayStrings: [String] = []
    var arrayImages: [UIImage] = []
    var arrayProducts: [Product] = []
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataBase.allProductsDB[itemProductInTLCVC!].productPostArrayPhotos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellStore = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifierAlbum.rawValue, for: indexPath) as! PhotoAlbumCollectionViewCell
        
        let cellStore1 = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifierAlbum.rawValue, for: indexPath) as! PhotoAlbumCollectionViewCell
        
        cellStore.albumImage.image = UIImage(systemName: "pencil")
        
        guard AuthAccaunt.authProfile == .nonAuth || AuthAccaunt.authProfile == .user else {

            let myProducts = DataBase.generateArray(name: AuthAccaunt.nameStore).0
            
            cellStore.albumImage.image = myProducts[itemProductInTLCVC!].productPostArrayPhotos![indexPath.item]
            
            return cellStore
        }
        cellStore1.albumImage.image = DataBase.allProductsDB[itemProductInTLCVC!].productPostArrayPhotos![indexPath.item]
        return cellStore1
    }

    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.delegate = self
        self.dataSource = self
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        recognizer.numberOfTapsRequired = 2
        self.addGestureRecognizer(recognizer)
    }
    
    
    @objc private func tap(sender: UITapGestureRecognizer) {
        if self.heartImage.image == UIImage(systemName: "heart.fill") {
            self.heartImage.image = UIImage(systemName: "heart")
        } else { self.heartImage.image = UIImage(systemName: "heart.fill") }
       
    }
        
    
}

