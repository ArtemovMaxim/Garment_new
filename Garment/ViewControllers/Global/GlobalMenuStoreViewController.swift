//
//  GlobalMenuStoreViewController.swift
//  Garment
//
//  Created by Максим Артемов on 11.10.2021.
//

import UIKit

class GlobalMenuStoreViewController: UIViewController {
    
    //IBOutlets
    
    //IBActions
    @IBAction func creatNewProductButtonAction(_ sender: Any) {
    }
    @IBAction func myProductsButtonAction(_ sender: Any) {
    }
    @IBAction func settingsMyStoreButtonAction(_ sender: Any) {
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
