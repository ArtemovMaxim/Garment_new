//
//  GlobalMenuStoreViewController.swift
//  Garment
//
//  Created by Максим Артемов on 11.10.2021.
//

import UIKit
import Firebase

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
        do {
            try Auth.auth().signOut()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let authVC = storyboard.instantiateViewController(withIdentifier: "AuthVC") as! AuthViewController
            
            ProductViewController.photos.removeAll()
            ProductViewController.currentProduct?.productPostArrayPhotos = []
            
            self.navigationController?.pushViewController(authVC, animated: true)
            self.navigationController?.setViewControllers([authVC], animated: true)
            
        } catch let error {
            print("Error trying to sign out of Firebase: \(error.localizedDescription)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromGlobalToTL" {
            TimeLineCollectionViewController.myProducts = DataBase.generateArray(name: AuthAccaunt.nameStore).0
            ProductViewController.photos.removeAll()
            ProductViewController.currentProduct?.productPostArrayPhotos = []
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
}
