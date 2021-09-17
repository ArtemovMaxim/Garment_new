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
    
    
    @IBOutlet weak var productPostImage: UIImageView!
    
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
    
    
    @IBOutlet weak var buttons: UIStackView!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    
    override class func awakeFromNib() {
        

        super.awakeFromNib()
        
    }
        
    //custom Function
     
    
    func fillingField(indexPath: IndexPath) {
//        var dataBaseDB = DataBase()
//        dataBaseDB.addProductToDB()
        
 
        //header
//        productPostArticleLabel.text = dataBaseDB.db[indexPath.item].productPostArticle
//        productPostViewsLabel.text = String(dataBaseDB.db[indexPath.item].productPostViewsCount)
//        productPostLikesCountLabel.text = String(dataBaseDB.db[indexPath.item].productPostLikesCount)
//        productPostCommentsCountLabel.text = String(dataBaseDB.db[indexPath.item].productPostCommentsCount)
//        
//        //productPostImage
//        productPostImage.image = dataBaseDB.db[indexPath.item].productPostImage
//        
//        //productDescription
//        productPostDescriptionLabel.text = dataBaseDB.db[indexPath.item].productPostDescription
//        productPostTitleLabel.text = dataBaseDB.db[indexPath.item].productPostTitle
//        
//        //footer
//        //productPropertys
//        productPostSexLabel.text = dataBaseDB.db[indexPath.item].productPostSex?.rawValue
//        productPostSeasonLabel.text = dataBaseDB.db[indexPath.item].productPostSeason?.rawValue
//        
//        //productPrice
//        productPostPriceLabel.text = String(dataBaseDB.db[indexPath.item].productPostPrice) + " руб."
//        productPostDiscontLabel.text = "\(dataBaseDB.db[indexPath.item].productPostDiscont ?? 0)" + " %"
//        productPostFinalPriceLabel.text = "\(dataBaseDB.db[indexPath.item].productPostFinalPrice)" + " руб."
//        
//        productPostPublicationDateLabel.text = "Сегодняшняя дата"
        }
    
    
    func allHeights() -> CGFloat {
        //высоты объектов
        let heightHeader = header.frame.height
        let heightProductDescription = productDescription.frame.height
        let heightFooter = footer.frame.height
        let heightButtons = buttons.frame.height
        //        let heightScreen = UIScreen.main.bounds.height
        let allHeights = heightHeader + heightProductDescription + heightFooter + heightButtons
        
        //высоты отступов
        let insets = header.spacing + productDescription.spacing + footer.spacing + buttons.spacing + 20 /*высота отступов над и под productPostImage*/
        
        return allHeights + insets
    }
    
    func configureTimeLineCell() {
        //        productArticle.text = generateNewArticle()
        
       
    }
}

