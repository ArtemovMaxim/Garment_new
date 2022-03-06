//
//  StorePhotoAlbumCollectionViewCell.swift
//  Garment
//
//  Created by Максим Артемов on 20.09.2021.
//

import UIKit

class StorePhotoAlbumCollectionViewCell: UICollectionViewCell {
    
    //outlets
    //Photo album cell
    @IBOutlet weak var StoresVCCollectionVCPhotoAlbumImage: UIImageView!
    
    override func draw(_ rect: CGRect) {
        StoresVCCollectionVCPhotoAlbumImage.image = nil
    }
    
}

