//
//  TimeLineCollectionViewController.swift
//  Garment
//
//  Created by Максим Артемов on 11.09.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class TimeLineCollectionViewController: UICollectionViewController {
    
    //var
    
    var dataBase = DataBase()

    
    
    //аутлеты
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataBase.addProductToDB()

        //custom function
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    
    
    
    //    product1.productPostArticle = product1.generateNewArticle()
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataBase.db.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TimeLineCollectionViewCell
        
        //отключение автомата
        cell.header.translatesAutoresizingMaskIntoConstraints = false
        cell.productPostImage.translatesAutoresizingMaskIntoConstraints = false
        cell.productDescription.translatesAutoresizingMaskIntoConstraints = false
        cell.footer.translatesAutoresizingMaskIntoConstraints = false
        cell.buttons.translatesAutoresizingMaskIntoConstraints = false

        //констрейнты
        NSLayoutConstraint.activate([

            //header
            cell.header.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
            cell.header.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: 10),
            cell.header.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),

            //productPostImage
            cell.productPostImage.topAnchor.constraint(equalTo: cell.header.bottomAnchor, constant: 10),
            cell.productPostImage.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: 10),
            cell.productPostImage.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),

            cell.productPostImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - cell.allHeights()),

            //productDescription
            cell.productDescription.topAnchor.constraint(equalTo: cell.productPostImage.bottomAnchor, constant: 10),
            cell.productDescription.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: 10),
            cell.productDescription.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),

            //footer
            cell.footer.topAnchor.constraint(equalTo: cell.productDescription.bottomAnchor, constant: 10),
            cell.footer.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: 10),
            cell.footer.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),

            //buttons
            cell.buttons.topAnchor.constraint(equalTo: cell.footer.bottomAnchor, constant: 10),
            cell.buttons.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: 10),
            cell.buttons.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),


        ])
        
        // Configure the cell
 
        //header
        cell.productPostArticleLabel.text = dataBase.db[indexPath.item].productPostArticle
        cell.productPostViewsLabel.text = String(dataBase.db[indexPath.item].productPostViewsCount)
        cell.productPostLikesCountLabel.text = String(dataBase.db[indexPath.item].productPostLikesCount)
        cell.productPostCommentsCountLabel.text = String(dataBase.db[indexPath.item].productPostCommentsCount)

        //productPostImage
        cell.productPostImage.image = dataBase.db[indexPath.item].productPostImage

        //productDescription
        cell.productPostDescriptionLabel.text = dataBase.db[indexPath.item].productPostDescription
        cell.productPostTitleLabel.text = dataBase.db[indexPath.item].productPostTitle

        //footer
        //productPropertys
        cell.productPostSexLabel.text = dataBase.db[indexPath.item].productPostSex?.rawValue
        cell.productPostSeasonLabel.text = dataBase.db[indexPath.item].productPostSeason?.rawValue

        //productPrice
        cell.productPostPriceLabel.text = String(dataBase.db[indexPath.item].productPostPrice) + " руб."
        cell.productPostDiscontLabel.text = "\(dataBase.db[indexPath.item].productPostDiscont ?? 0)" + " %"
        cell.productPostFinalPriceLabel.text = "\(dataBase.db[indexPath.item].productPostFinalPrice)" + " руб."

        cell.productPostPublicationDateLabel.text = "Сегодняшняя дата"
        return cell
    }
    
    
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
