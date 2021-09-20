//
//  StoresViewController.swift
//  Garment
//
//  Created by Максим Артемов on 19.09.2021.
//

import UIKit

class StoresViewController: UIViewController {
    
    //IBOutlets
    //labels
    @IBOutlet weak var StoresVCArticleLabel: UILabel!
    @IBOutlet weak var StoresVCFotosLabel: UILabel!
    @IBOutlet weak var StoresVCDiscriptionLabel: UILabel!
    @IBOutlet weak var StoresVCSexLabel: UILabel!
    @IBOutlet weak var StoresVCSeasonLabel: UILabel!
    @IBOutlet weak var StoresVCPriceLabel: UILabel!
    @IBOutlet weak var StoresVCDiscountLabel: UILabel!
    @IBOutlet weak var StoresVCFinalPriceLabel: UILabel!
    @IBOutlet weak var StoresVCDatePostingLabel: UILabel!
    @IBOutlet weak var StoresVCDatePostLabel: UILabel!
    @IBOutlet weak var StoreVcProductTitleLabel: UILabel!
    @IBOutlet weak var StoreVCisNewLabel: UILabel!

    
    //feilds
    @IBOutlet weak var StoresVCArticleField: UITextField!
    @IBOutlet weak var StoresVCDiscriptionField: UITextView!
    @IBOutlet weak var StoresVCPriceField: UITextField!
    @IBOutlet weak var StoresVCDiscountField: UITextField!
    @IBOutlet weak var StoresVCFinalPriceField: UITextField!
    @IBOutlet weak var StoresVCProductTitleField: UITextField!
    
    
    //segmentedControllers
    @IBOutlet weak var StoresVCSexSC: UISegmentedControl!
    @IBOutlet weak var StoresVCSeasonSC: UISegmentedControl!
    @IBOutlet weak var StoresVCisNewSC: UISegmentedControl!
    
    
    //stepper
    @IBOutlet weak var StoresVCDiscountStepper: UIStepper!
    
    //posting date
    @IBOutlet weak var StoresVCPostingDatePicker: UIDatePicker!
    
    //image
    @IBOutlet weak var StoreVСProductImage: UIImageView!
    
    //buttons
    @IBOutlet weak var StoreVCPostingButtonOutlet: UIButton!
    
    //dataPicker
    @IBOutlet weak var StoreVCDataPickerOutlet: UIDatePicker!
    
    
    
    //IBActions
    //buttons
    @IBAction func StoreVCPostingButtonAction(_ sender: Any) {
    }
    
    //stepper
    @IBAction func StoreVCDiscountStepperAction(_ sender: Any) {
        StoresVCDiscountField.text = String(Int(StoresVCDiscountStepper.value)) + " %"
        StoresVCFinalPriceField.text = generateFinalPrice()
    }
    
    //datePicker
    @IBAction func StoresVCDataPickerAction(_ sender: Any) {
        StoreVCPostingButtonOutlet.setTitle(generateDatePosting(), for: .normal)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StoreVCPostingButtonOutlet.setTitle(generateDatePosting(), for: .normal)
        
        //отключение авторесайзинга
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func addNewProduct() {

        let newProduct = ProductPost(productPostArticle: "123артикул",
                                     productPostImage: ((self.StoreVСProductImage.image ?? UIImage(named: "pencil"))!),
                                     productPostTitle: self.StoresVCProductTitleField.text ?? "Нет названия товара",
                                     productPostDescription: self.StoresVCDiscriptionField.text ?? "Нет описния товара",
                                     productPostPrice: (self.StoresVCPriceField.text! as NSString).integerValue,
                                     productPostDiscont: (self.StoresVCDiscountField.text! as NSString).doubleValue ,
                                     productPostFinalPrice: self.generateFinalPrice(),
                                     productPostSex: choiceSex(sex: self.StoresVCSexSC.selectedSegmentIndex),
                                     productPostSeason: choiceSeason(season: self.StoresVCSeasonSC.selectedSegmentIndex),
                                     productPostPublicationDate: Date(),
                                     productPostLikesCount: 0,
                                     productPostIsLiked: false,
                                     productPostViewsCount: 0,
                                     productPostComments: nil,
                                     productPostCommentsCount: 0,
                                     productPostIsNew: choiceIsNew(isNew: self.StoresVCisNewSC.selectedSegmentIndex))
     
        
        DataBase.addNewProductToDB(product: newProduct)
//        let dataBase = DataBase()
//        dataBase.db.append(newProduct)
        
    }
    
    func choiceSex(sex: Int) -> ProductPost.Sex {
        switch sex {
        case 0: return ProductPost.Sex.man
        case 1: return ProductPost.Sex.woman
        case 2: return ProductPost.Sex.unisex
        
        default:
            return ProductPost.Sex.unisex
        }
    }
    
    func choiceSeason(season: Int) -> ProductPost.Season {
        switch season {
        case 0: return ProductPost.Season.winter
        case 1: return ProductPost.Season.spring
        case 2: return ProductPost.Season.summer
        case 3: return ProductPost.Season.autumn
        
        default:
            return ProductPost.Season.winter
        }
    }
    
    func choiceIsNew(isNew: Int) -> ProductPost.New {
        switch isNew {
        case 0: return ProductPost.New.isNew
        case 1: return ProductPost.New.normal
        case 2: return ProductPost.New.sale
        
        default:
            return ProductPost.New.normal
        }
    }
    
    func generateFinalPrice() -> String {
        let priceFirst = (StoresVCPriceField.text! as NSString).floatValue
        let discountPercent = (StoresVCDiscountField.text! as NSString).floatValue
        let onePercent = priceFirst / 100
        let final = priceFirst - onePercent * discountPercent
        
        return String(final) + " руб."
       
    }
    
    
    func generateDatePosting() -> String {
        let currentDate = StoresVCPostingDatePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy HH:mm"
        let dateToField = dateFormater.string(for: currentDate)
        return " Опубликовать товар " + dateToField! + " "
        
    
        
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

