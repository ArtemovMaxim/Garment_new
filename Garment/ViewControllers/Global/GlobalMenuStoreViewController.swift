//
//  GlobalMenuStoreViewController.swift
//  Garment
//
//  Created by Максим Артемов on 11.10.2021.
//

import UIKit
//import Firebase

class GlobalMenuStoreViewController: UIViewController {
    
    //IBOutlets
    
    //IBActions
    @IBAction func creatNewProductButtonAction(_ sender: Any) {
    }
    
    @IBAction func myProductsButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "fromGlobalToTL", sender: nil)
    }
    
    @IBAction func settingsMyStoreButtonAction(_ sender: Any) {
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
//        do {
//            try Auth.auth().signOut()
//        } catch let error {
//            print("Error trying to sign out of Firebase: \(error.localizedDescription)")
//        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "fromGlobalToTL" {
//            
//            guard let source = segue.source as? GlobalMenuStoreViewController,
//                  let destination = segue.destination as? TimeLineCollectionViewController
//            else { return }
//            FBDataBase.creatUserTimeLineProducts { prodArray in
//                TimeLineCollectionViewController.allPrdcsArr = prodArray
//                print("препер генерация массива всех продуктов \(TimeLineCollectionViewController.allPrdcsArr.count)")
//                
//            }
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
}
