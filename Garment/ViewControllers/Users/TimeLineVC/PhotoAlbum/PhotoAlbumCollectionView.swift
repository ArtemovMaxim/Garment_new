//
//  PhotoAlbumCollectionView.swift
//  Garment
//
//  Created by Максим Артемов on 02.10.2021.
//

import UIKit
import Firebase
import SDWebImage

class PhotoAlbumCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionHeight = self.layer.bounds.height
        let collectionWidth = self.layer.bounds.width
        
        let cellSize = CGSize(width: collectionWidth, height: collectionHeight)
        
        print(collectionHeight)
        print(collectionWidth)
        return cellSize
    }
    
    
    var index = TimeLineCollectionViewController.item
    var itemsCount: Int = 0
//    let productItemFromTLCVC = TimeLineCollectionViewController.item
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("numberOfSection")
        
        return 1
    }
    
    
    
// вычисление количества фотографий у товара
    func loadCount(index: Int, completion: @escaping (Product?, Error?, Int) -> ()) {
        
        switch AuthAccaunt.authProfile {
        case .user:
            FBDataBase().creatUserTimeLineProducts { allProducts in
                let count = allProducts[index].productPostPhotoCount
                let product = allProducts[index]
                completion(product, nil, count)
            }
        case .store:
//            получаем все товары всех магазинов
            FBDataBase().creatUserTimeLineProducts { allProducts in
                let count = allProducts[index].productPostPhotoCount
                let product = allProducts
                completion(nil, nil, count)

//                let val = allProducts[index].productPostArrayPhotos?.count
            }
            
            
            let currentUser = Auth.auth().currentUser?.email // переменная с текущим юзером
            
            let ref = Firestore.firestore().collection("stores").document(currentUser!).collection("products").document("\(String(index + 1))")
            ref.getDocument(completion: { (prod, error) in
                let count = try! prod?.data()!["productPostPhotoCount"] as! Int
                print("loadCount: \(count)")
                let product = try? prod?.data(as: Product.self)
                completion(product!, error, count)
            })
        case .nonAuth:
            FBDataBase().creatUserTimeLineProducts { allProducts in
                let count = allProducts[index].productPostPhotoCount
                let product = allProducts[index]
                completion(product, nil, count)
            }
        }
        
        
//        let currentUser = Auth.auth().currentUser?.email // переменная с текущим юзером
//
//        let ref = Firestore.firestore().collection("stores").document(currentUser!).collection("products").document("\(String(index + 1))")
//        ref.getDocument(completion: { (product, error) in
//            let count = try! product?.data()!["productPostPhotoCount"] as! Int
//            print("loadCount: \(count)")
//            completion(product, error, count)
//        })
    }
    
//    var counter: Int = 0
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection")
        
        print("itemsCount = \(self.itemsCount)")
        return self.itemsCount
    }
    
    
    
    var arrayStrings: [Any] = []
    var arrayImages: [UIImage] = []
    var arrayProducts: [Product] = []
    
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser?.email
    
    func loadArray(indexP: IndexPath?, productItem: Int, completion: @escaping ([UIImage]) -> ())  {
        var arrayURLs: [String] = []
        loadCount(index: self.index) { product, error, count in
            let countPhotos = count
            
//            for string in 1...countPhotos {
//                self.arrayStrings.append(product.productPostArrayPhotos![string])
//                self.arrayStrings.append(product. )
////                self.arrayStrings.append((product?.data()!["URL \(String(string))"])!/* as! String*/)
//            }
            print("arrayStrings: \(self.arrayStrings.count)")
            print("arrayStrings: \(self.arrayStrings)")
//            for image in 0...countPhotos - 1 {
//                self.db.collection("stores").document(self.currentUser!).collection("products").document("\(count)").getDocument { fields, error in
//                    let urls = fields!.get("URL's") as! [String: Any]
//                    for url in urls {
//                        arrayURLs.append((url.value as! String))
//                    }
//
//                }
//                self.arrayImages.append(UIImage(data: try! Data(contentsOf: URL(string: self.arrayStrings[image] as! String)!))!)
//            }
            print("arrayImage: \(self.arrayImages.count)")
            completion(self.arrayImages)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItem")
        
        let cellStore = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifierAlbum.rawValue, for: indexPath) as! PhotoAlbumCollectionViewCell
        
        let cellStore1 = collectionView.dequeueReusableCell(withReuseIdentifier: Ident.reuseIdentifierAlbum.rawValue, for: indexPath) as! PhotoAlbumCollectionViewCell
        


        
        cellStore.albumImage.image = UIImage(systemName: "pencil")
        
        guard AuthAccaunt.authProfile == .nonAuth || AuthAccaunt.authProfile == .user else {
            
            print("index: \(self.index)")
            
            DispatchQueue.global().async {
                self.loadArray(indexP: nil, productItem: self.index) { array in
                    self.arrayImages = array
                    print("LoadArray count: \(self.arrayImages.count)")

                    DispatchQueue.main.async {
                        cellStore.albumImage.image = self.arrayImages[indexPath.item]
                        print("LoadArray count: \(self.arrayImages.count)")

                    }
                }
            }

            
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
        
        let currentUser = Auth.auth().currentUser?.email // переменная с текущим юзером
        let ref = Firestore.firestore().collection("stores").document(currentUser!).collection("products")
        ref.getDocuments { products, error in
            self.itemsCount = (products?.documents.count)!
        }
        
        self.loadArray(indexP: nil, productItem: self.index) { array in
            self.arrayImages = array
            print("LoadArray count: \(self.arrayImages.count)")

        }
        
        
//        количество фотографий у товара
        self.loadCount(index: self.index) { product, error, count1 in
            self.itemsCount = count1
            self.reloadData()
            print("Count in draw: \(count1)")
        }
        
        // Drawing code
        
        self.delegate = self
        self.dataSource = self
        
    }
}

