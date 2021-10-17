//
//  TimeLineCollectionViewCell.swift
//  Garment
//
//  Created by Максим Артемов on 11.09.2021.
//

import UIKit

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
    
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
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
}


