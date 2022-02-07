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

    }
    
    @IBAction func settingsMyStoreButtonAction(_ sender: Any) {
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        do {
                try Auth.auth().signOut()
            } catch let error {
                print("Error trying to sign out of Firebase: \(error.localizedDescription)")
            }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let AuthVC = storyboard.instantiateViewController(withIdentifier: "AuthVC") as! AuthViewController

        self.navigationController?.pushViewController(AuthVC, animated: true)
        self.navigationController?.setViewControllers([AuthVC], animated: true)

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
