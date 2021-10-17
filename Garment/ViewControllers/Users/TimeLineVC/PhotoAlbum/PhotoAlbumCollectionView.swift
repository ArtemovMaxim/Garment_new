//
//  PhotoAlbumCollectionView.swift
//  Garment
//
//  Created by Максим Артемов on 02.10.2021.
//

import UIKit

class PhotoAlbumCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var index = TimeLineCollectionViewController.item

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionHeight = self.layer.bounds.height
        let collectionWidth = self.layer.bounds.width
        
        let cellSize = CGSize(width: collectionWidth, height: collectionHeight)
        
        print(collectionHeight)
        print(collectionWidth)
        return cellSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DataBase.productsDb[index].productPostArrayPhotos!.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var currentIndex = 0
        
        guard AuthAccaunt.authProfile == .nonAuth && AuthAccaunt.authProfile == .user else {
        let cellStore = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifierAlbum.rawValue, for: indexPath) as! PhotoAlbumCollectionViewCell
        
        let array = DataBase().generateArray(name: AuthAccaunt.nameStore)
            cellStore.albumImage.image = array[index].productPostArrayPhotos![indexPath.item]
        
        
        return cellStore
        }
        
                
            let cellUserOrNonAuth = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifierAlbum.rawValue, for: indexPath) as! PhotoAlbumCollectionViewCell
            
        let array = DataBase().generateArray(name: "")
            cellUserOrNonAuth.albumImage.image = array[currentIndex].productPostArrayPhotos![indexPath.item]
        currentIndex += 1
            
            
            return cellUserOrNonAuth
            
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.delegate = self
        self.dataSource = self
    }
}
