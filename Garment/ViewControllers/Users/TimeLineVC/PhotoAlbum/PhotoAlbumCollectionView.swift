//
//  PhotoAlbumCollectionView.swift
//  Garment
//
//  Created by Максим Артемов on 02.10.2021.
//

import UIKit
//import Firebase
//import SDWebImage

class PhotoAlbumCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionHeight = self.layer.bounds.height
        let collectionWidth = self.layer.bounds.width
        
        let cellSize = CGSize(width: collectionWidth, height: collectionHeight)
        
        print(collectionHeight)
        print(collectionWidth)
        return cellSize
    }
    
    
    var itemProductInTLCVC = TimeLineCollectionViewController.indexPathItemTLCVC
    var indexPathTLCVC = TimeLineCollectionViewController.indexPathTLCVC
    var countImages: Int = 0
    //    let productItemFromTLCVC = TimeLineCollectionViewController.item
    
    
    // вычисление количества фотографий у товара
    func countPhotoInProduct(indProductInTLCVC: Int, completion: @escaping (Product?, Error?, Int) -> ()) {
        
        switch AuthAccaunt.authProfile {
        case .user:
            let count = TimeLineCollectionViewController.allPrdcsArr[indProductInTLCVC].productPostPhotoCount
            let currentProduct = TimeLineCollectionViewController.allPrdcsArr[indProductInTLCVC]
            completion(currentProduct, nil, count)
            
        case .store:
            //            получаем все товары всех магазинов
            let countPhotos = TimeLineCollectionViewController.allPrdcsArr[indProductInTLCVC].productPostPhotoCount
            let currentProduct = TimeLineCollectionViewController.allPrdcsArr[indProductInTLCVC]
            print("ПродАррей в ФотоАлбум: \(TimeLineCollectionViewController.allPrdcsArr.count)")
            completion(currentProduct, nil, countPhotos)
            
        case .nonAuth:
            let countPhotos = TimeLineCollectionViewController.allPrdcsArr[indProductInTLCVC].productPostPhotoCount
            let currentProduct = TimeLineCollectionViewController.allPrdcsArr[indProductInTLCVC]
            print("ПродАррей в ФотоАлбум: \(TimeLineCollectionViewController.allPrdcsArr.count)")
            completion(currentProduct, nil, countPhotos)
        }
    }
    
    var arrayStrings: [String] = []
    var arrayImages: [UIImage] = []
    var arrayProducts: [Product] = []
    
//    let db = Firestore.firestore()
//    let currentUser = Auth.auth().currentUser?.email
    
    func arrayImages(indexP: IndexPath?, productItem: Int, completion: @escaping ([UIImage]) -> ())  {
//        var arrayURLs: [String] = []
//        countPhotoInProduct(indProductInTLCVC: self.itemProductInTLCVC) { currentProduct, error, countPhotos in
//
//            for image in 0...countPhotos - 1 {
//                self.db.collection("stores").document(self.currentUser!).collection("products").document("\(self.itemProductInTLCVC)").getDocument { fields, error in
//                    let urls = fields!.get("URL's") as! [String: Any]
//                    print("URL's: \(urls.count)")
//
//                    for url in urls {
//                        arrayURLs.append((url.value as! String))
//                    }
//
//                }
//                self.arrayStrings = FBDataBase.strAnyArr
//                self.arrayImages.append(UIImage(data: try! Data(contentsOf: URL(string: self.arrayStrings[image] )!))!)
//            }
//        }
        print("arrayImage: \(self.arrayImages.count)")
        completion(self.arrayImages)
    }
    
    //    var currentImage: UIImage?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("numberOfSection")
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.countImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellStore = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifierAlbum.rawValue, for: indexPath) as! PhotoAlbumCollectionViewCell
        
        let cellStore1 = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifierAlbum.rawValue, for: indexPath) as! PhotoAlbumCollectionViewCell
        
        cellStore.albumImage.image = UIImage(systemName: "pencil")
        
        guard AuthAccaunt.authProfile == .nonAuth || AuthAccaunt.authProfile == .user else {
            
            //            print("cellForItemAt self.index: \(self.indexProductInTLCVC)")
            //            print("indexPath.item: \(indexPath.item)")
            //            let allProducts = TimeLineCollectionViewController.allPrdcsArr
            ////            FBDataBase.creatUserTimeLineProducts { allProducts in
            //                let currentPhotoString = allProducts[self.indexProductInTLCVC].productPostArrayPhotos![indexPath.item]
            //
            //                let currentImg = UIImage(data: try! Data(contentsOf: URL(string: currentPhotoString)!))
            //                self.currentImage = currentImg
            //            }
            //            DispatchQueue.global().async {
            //                self.loadArray(indexP: nil, productItem: self.index) { array in
            //                    self.arrayImages = array
            //                    print("LoadArray count: \(self.arrayImages.count)")
            //
            //                    DispatchQueue.main.async {
            //                        cellStore.albumImage.image = self.arrayImages[indexPath.item]
            //                        print("LoadArray count: \(self.arrayImages.count)")
            //
            //                    }
            //                }
            //            }
            
            
            return cellStore
        }
        return cellStore1
    }
    
    
    
    
    //        let cellUserOrNonAuth = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifierAlbum.rawValue, for: indexPath) as! PhotoAlbumCollectionViewCell
    //
    //        self.arrayStrings.removeAll()
    //        return cellUserOrNonAuth
    //
    //
    //        let cellUserOrNonAuth = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifierAlbum.rawValue, for: indexPath) as! PhotoAlbumCollectionViewCell
    //
    //        //        let array = DataBase().generateArray(name: "")
    //        //            cellUserOrNonAuth.albumImage.image = array[currentIndex].productPostArrayPhotos![indexPath.item]
    //        //        currentIndex += 1
    //
    //
    //        return cellUserOrNonAuth
    
    override func draw(_ rect: CGRect) {
        print("draw")
        
//        let currentUser = Auth.auth().currentUser?.email // переменная с текущим юзером
//        let ref = Firestore.firestore().collection("stores").document(currentUser!).collection("products")
//        //        ref.getDocuments { products, error in
//        //            self.itemsCount = (products?.documents.count)!
//        //        }
        
        self.arrayImages(indexP: self.indexPathTLCVC, productItem: self.itemProductInTLCVC) { array in
            self.arrayImages = array
            print("LoadArray count: \(self.arrayImages.count)")
        }
        
        
        //        количество фотографий у товара
        //        self.countPhotoInProduct(indProductInTLCVC: self.indexProductInTLCVC) { product, error, count1 in
        //            self.countImages = count1
        //            self.reloadData()
        //            print("Count in draw: \(count1)")
        //        }
        
        // Drawing code
        
        self.delegate = self
        self.dataSource = self
        
    }
}

