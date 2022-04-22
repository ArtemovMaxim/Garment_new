//
//  StoresViewController.swift
//  Garment
//
//  Created by Максим Артемов on 19.09.2021.
//

import UIKit
//import Firebase

class ProductViewController: UIViewController, UIImagePickerControllerDelegate ,  UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductViewController.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! StorePhotoAlbumCollectionViewCell
        
        
        //       cell.StoresVCCollectionVCPhotoAlbumImage.image = UIImage(systemName: "pencil")
        cell.StoresVCCollectionVCPhotoAlbumImage.image = ProductViewController.photos[indexPath.item]
        return cell
    }
    
    static var productArticle = ""
    
    var alerts: String = "" // массив ошибок заполнения полей
    enum alertEnumStores: String {
        
        case noStore = " название магазина"
        case noProductPostArrayPhotos = " фотографии товара"
        case noroductPostFirstImage = " главное фото товара"
        case noProductPostTitle = " название товара"
        case noProductPostPrice = " цена товара"
        case noProductPostDiscont = " размер скидки"
        case noProductPostSex = " гендерную принадлежность товара"
        case noProductPostSeason = " сезонность товара"
        case noProductPostIsNew = " категорию новызны товара"
    }
    
    static var photos: [UIImage] = []
    
    
    
    //IBOutlets
    //labels
    @IBOutlet weak var StoresVCArticleLabel: UILabel!
    @IBOutlet weak var StoresVCDescriptionLabel: UILabel!
    @IBOutlet weak var StoresVCSexLabel: UILabel!
    @IBOutlet weak var StoresVCSeasonLabel: UILabel!
    @IBOutlet weak var StoresVCPriceLabel: UILabel!
    @IBOutlet weak var StoresVCDiscountLabel: UILabel!
    @IBOutlet weak var StoresVCFinalPriceLabel: UILabel!
    @IBOutlet weak var StoresVCDatePostingLabel: UILabel!
    @IBOutlet weak var StoreVcProductTitleLabel: UILabel!
    @IBOutlet weak var StoreVCisNewLabel: UILabel!
    
    
    //feilds
    @IBOutlet weak var StoresVCArticleField: UITextField!
    @IBOutlet weak var StoresVCDescriptionField: UITextView!
    @IBOutlet weak var StoresVCPriceField: UITextField!
    @IBOutlet weak var StoresVCDiscountField: UITextField!
    @IBOutlet weak var StoresVCFinalPriceField: UITextField!
    @IBOutlet weak var StoresVCProductTitleField: UITextField!
    
    
    //SegmentedControllers
    @IBOutlet weak var StoresVCSexSC: UISegmentedControl!
    @IBOutlet weak var StoresVCSeasonSC: UISegmentedControl!
    @IBOutlet weak var StoresVCisNewSC: UISegmentedControl!
    
    
    //Stepper
    @IBOutlet weak var StoresVCDiscountStepper: UIStepper!
    
    //posting date
    @IBOutlet weak var StoresVCPostingDatePicker: UIDatePicker!
    
    //image
    
    //buttons
    @IBOutlet weak var StoreVCPostingButtonOutlet: UIButton!
    @IBOutlet weak var StoresVCCustomArticleButtonOutlet: UIButton!
    @IBOutlet weak var StoresVCUploadPhotoButtonOutlet: UIButton!
    
    //DataPicker
    @IBOutlet weak var StoreVCDataPickerOutlet: UIDatePicker!
    
    //CollectionView
    @IBOutlet weak var StoresVCPhotosCollectionViewOutlet: UICollectionView!
    
    
    
    //IBActions
    //buttons
    
    @IBAction func toGlobalMenuButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let globalMenu = storyboard.instantiateViewController(withIdentifier: "GlobalMenuStoreViewController") as! GlobalMenuStoreViewController
        self.navigationController?.pushViewController(globalMenu, animated: true)
        self.navigationController?.setViewControllers([globalMenu], animated: true)
    }
    
    //upload seconds photo
    @IBAction func StoresVCUploadPhotoButtonAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
        //        StoresVCUploadPhotoButtonOutlet.tag = 1
    }
    
    //custom article
    @IBAction func StoresVCCustomArticleButtonAction(_ sender: Any) {
        if StoresVCArticleField.tag == 0 {
            StoresVCArticleField.isEnabled = true
            StoresVCArticleField.backgroundColor = .white
            StoresVCArticleField.becomeFirstResponder()
            StoresVCArticleField.tag = 1
            StoresVCCustomArticleButtonOutlet.setTitle("Сохранить", for: .normal)
        } else if StoresVCArticleField.tag == 1 {
            StoresVCArticleField.isEnabled = false
            StoresVCArticleField.backgroundColor = .opaqueSeparator
            StoresVCProductTitleField.becomeFirstResponder()
            StoresVCArticleField.tag = 0
            StoresVCCustomArticleButtonOutlet.setTitle("Изменить", for: .normal)
        }
    }
    
    //        пкбликация товара
    @IBAction func StoreVCPostingButtonAction(_ sender: Any) {
        ProductViewController.productArticle = StoresVCArticleField.text!
        
        ProductViewController.currentProduct = creatNewProduct()
        
        ProductViewController.currentProduct?.productPostPhotoCount = ProductViewController.photos.count
        
        print("Количество фото: \(ProductViewController.photos.count)")
        
        ProductViewController.currentProduct?.productPostArrayPhotos = ProductViewController.photos
        
        // проверяем на заполненность полей
        self.showAlert()
        
        DataBase.allProductsDB.append(ProductViewController.currentProduct!)
        
        // переход на глобальное меню
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let globalMenu = storyboard.instantiateViewController(withIdentifier: "GlobalMenuStoreViewController") as! GlobalMenuStoreViewController
        
        self.navigationController?.pushViewController(globalMenu, animated: true)
        self.navigationController?.setViewControllers([globalMenu], animated: true)
    }
    
    // создаем новый продукт
    static var currentProduct: Product?
    
    
    
    func creatNewProduct() -> Product {
        //        let array = FSStores.currentProductArrayStrings
        let newProduct = Product(
            store: AuthAccaunt.nameStore,
            productPostArticle: StoresVCArticleField.text!,
            productPostTitle: StoresVCProductTitleField.text!,
            productPostDescription: StoresVCDescriptionField.text!,
            productPostImageCount: 0,
            productPostPrice: Double(StoresVCPriceField.text!)!,
            productPostDiscont: Double(StoresVCDiscountField.text!)!,
            productPostFinalPrice: Double(StoresVCFinalPriceField.text!)!,
            productPostSex: StoresVCSexSC.titleForSegment(at: StoresVCSexSC.selectedSegmentIndex)!,
            productPostSeason: StoresVCSeasonSC.titleForSegment(at: StoresVCSeasonSC.selectedSegmentIndex)!,
            //            productPostPublicationDate: nil,
            productPostLikesCount: 0,
            productPostIsLiked: false,
            productLikes: [],
            productFollowers: [],
            productPostViewsCount: 0,
            productPostPhotoCount: 0,
            productPostIsNew: StoresVCisNewSC.titleForSegment(at: StoresVCisNewSC.selectedSegmentIndex)!,
            indexNumberOfProduct: (FBDataBase.count + 1), // присваиваем порядковый номер товару
            productPostArrayPhotos: nil, // добавили массив ссылок на фотографии
            messages: []
        )
        return newProduct
    }
    
    
    //stepper
    @IBAction func StoreVCDiscountStepperAction(_ sender: Any) {
        StoresVCDiscountField.text = String(Int(StoresVCDiscountStepper.value))
        StoresVCFinalPriceField.text = generateFinalPrice()
    }
    
    //datePicker
    @IBAction func StoresVCDataPickerAction(_ sender: Any) {
        StoreVCPostingButtonOutlet.setTitle(generateDatePosting(), for: .normal)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductViewController.photos.removeAll()
        
        //создание артикула
        StoresVCArticleField.text = Product.generateNewArticle()
        
        //установка текущей даты в DataPicker
        StoreVCPostingButtonOutlet.setTitle(generateDatePosting(), for: .normal)
        
        //установка фокуса на поле названия продукта
        StoresVCProductTitleField.becomeFirstResponder()
        
        self.StoresVCPhotosCollectionViewOutlet.dataSource = self
        self.StoresVCPhotosCollectionViewOutlet.delegate = self
        
    }
    
    
    //скрытие клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //custom functions
    
    //save photo in project
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue) ] as? UIImage
        //добавление в массив
//        ProductViewController.currentProduct?.productPostArrayPhotos = []
//        ProductViewController.photos.removeAll()
//
        ProductViewController.photos.append(image!)
        
        StoresVCPhotosCollectionViewOutlet.insertItems(at: StoresVCPhotosCollectionViewOutlet.indexPathsForVisibleItems)
        
        StoresVCPhotosCollectionViewOutlet.clipsToBounds = true
        
        //            StoresVCPhotosCollectionViewOutlet.reloadData()
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //выбор пола товара
    func choiceSex(sex: Int) -> Product.Sex {
        switch sex {
        case 0: return Product.Sex.man
        case 1: return Product.Sex.woman
        case 2: return Product.Sex.unisex
            
        default:
            return Product.Sex.unisex
        }
    }
    
    //выбор сезено товара
    func choiceSeason(season: Int) -> Product.Season {
        switch season {
        case 0: return Product.Season.winter
        case 1: return Product.Season.spring
        case 2: return Product.Season.summer
        case 3: return Product.Season.autumn
            
        default:
            return Product.Season.winter
        }
    }
    
    //опрделение новизны товара
    func choiceIsNew(isNew: Int) -> Product.New {
        switch isNew {
        case 0: return Product.New.isNew
        case 1: return Product.New.normal
        case 2: return Product.New.sale
            
        default:
            return Product.New.normal
        }
    }
    
    //формирование финальной цены со скидкой
    func generateFinalPrice() -> String {
        let priceFirst = (StoresVCPriceField.text! as NSString).floatValue
        let discountPercent = (StoresVCDiscountField.text! as NSString).floatValue
        let onePercent = priceFirst / 100
        let final = priceFirst - onePercent * discountPercent
        
        return String(final)
    }
    
    
    //формирование даты
    func generateDatePosting() -> String {
        let currentDate = StoresVCPostingDatePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy HH:mm"
        let dateToField = dateFormater.string(for: currentDate)
        return " Опубликовать товар " + dateToField! + " "
    }
    
    //insert photos in array
    func generatePhotosAlbumArray() -> [UIImage] {
        var array: [UIImage] = []
        let count = ProductViewController.photos.count
        for i in 0..<count {
            array.append(ProductViewController.photos[i])
        }
        return array
    }
    
    // проверка на заполнение полей
    func showAlert() {
        
        let alert = generateAlert()
        if  alert != "Вы не заполнили: \n" {
            let alertControllerAttention = UIAlertController(title: "Внимание!", message: alert, preferredStyle: .actionSheet)
            let alertAction = UIAlertAction(title: "Вернуться и добавить", style: .default, handler: nil)
            alertControllerAttention.addAction(alertAction)
            alerts.removeAll()
            present(alertControllerAttention, animated: true, completion: nil)
        }
    }
    
    // создание списка незаполненных полей
    func generateAlert() -> String {
        alerts.append("Вы не заполнили: \n")
        
        if ProductViewController.photos == [] {
            alerts.append(alertEnumStores.noProductPostArrayPhotos.rawValue + "\n")
        }
        
        if self.StoresVCProductTitleField.text == "" {
            alerts.append(alertEnumStores.noProductPostTitle.rawValue + "\n")
        }
        
        if self.StoresVCPriceField.text == "" {
            alerts.append(alertEnumStores.noProductPostTitle.rawValue + "\n")
        }
        
        if self.StoresVCDiscountField.text == "" {
            alerts.append(alertEnumStores.noProductPostDiscont.rawValue + "\n")
        }
        
        return alerts
    }
}

