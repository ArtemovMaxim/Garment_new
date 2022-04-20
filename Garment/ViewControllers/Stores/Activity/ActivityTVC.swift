//
//  ActivityTVC.swift
//  Garment
//
//  Created by Максим Артемов on 20.04.2022.
//

import UIKit

class ActivityTVC: UITableViewController {
    
    @IBOutlet weak var likesOrFollowers: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "activityCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // количество ячеек
        var count: Int = 0
        // если открывается закладка Подписчиков
        if self.likesOrFollowers.selectedSegmentIndex == 0 {
            // получаем количество Подписчиков в массиве Подписчиков
            count = getAllFollowers().count
            
        // если открывается закладка Лайков
        } else if self.likesOrFollowers.selectedSegmentIndex == 1 {
            // получаем количество Лайков в массиве Лайков
            count = getAllLikes().count
        }
        // возвращаем количество ячеек на закладке Подписчиков или Лайков
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
//        let cell = tableView.register(UITableViewCell.self, forCellReuseIdentifier: "activityCell")

        if self.likesOrFollowers.selectedSegmentIndex == 0 {
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: "person.fill.checkmark")
            let array = getAllFollowers()
            content.text = array[indexPath.row]
            cell.contentConfiguration = content
            
        } else if self.likesOrFollowers.selectedSegmentIndex == 1 {
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: "heart.circle.fill")
            let array = getAllLikes()
            content.text = array[indexPath.row]
            cell.contentConfiguration = content
        }
        return cell
    }
    
    @IBAction func changingSegment(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    func getAllLikes() -> [String] {
        var likesArray: [String] = []
        let productsWithLikes = DataBase.allProductsDB.filter { product in
            product.likes != []
        }
        
        var index: Int = 0
        for product in productsWithLikes {
            likesArray.append(product.likes[index])
            index += 1
        }
        return likesArray
    }
    
    func getAllFollowers() -> [String] {
        // создаем массив строк с Лайками
        var followersArray: [String] = []
        let productsWithFollowers = DataBase.allProductsDB.filter { product in
            product.followers != []
        }
        
        var index: Int = 0
        for product in productsWithFollowers {
            followersArray.append(product.followers[index])
            index += 1
        }
        return followersArray
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
