//
//  PhotoAlbumCollectionViewCell.swift
//  Garment
//
//  Created by Максим Артемов on 02.10.2021.
//

import UIKit

class PhotoAlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.albumImage.image = UIImage(systemName: "pencil")

    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
