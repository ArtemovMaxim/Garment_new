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
        } catch let error {
            print("Error trying to sign out of Firebase: \(error.localizedDescription)")
        }
        
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let AuthVC = storyboard.instantiateViewController(withIdentifier: "AuthVC") as! AuthViewController
        //
        //        self.navigationController?.pushViewController(AuthVC, animated: true)
        //        self.navigationController?.setViewControllers([AuthVC], animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromGlobalToTL" {
            
            guard let source = segue.source as? GlobalMenuStoreViewController,
                  let destination = segue.destination as? TimeLineCollectionViewController
            else { return }
            
            print("препер переход с Глобал на ТаймЛайн")
                            FBDataBase.creatUserTimeLineProducts { prodArray in
                    destination.allPrdcsArr = prodArray

            }
            print("препер генерация массива всех продуктов \(destination.allPrdcsArr.count)")

//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let TLCVC = storyboard.instantiateViewController(withIdentifier: "TimeLineCollectionViewController") as! TimeLineCollectionViewController
//
//            self.navigationController?.pushViewController(TLCVC, animated: true)
//            self.navigationController?.setViewControllers([TLCVC], animated: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
