//
//  StoresViewController.swift
//  Garment
//
//  Created by Максим Артемов on 19.09.2021.
//

import UIKit
import Firebase
//import FirebaseStorage

class StoresViewController: UIViewController, UIImagePickerControllerDelegate ,  UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StoresViewController.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! StorePhotoAlbumCollectionViewCell
        
        
        //       cell.StoresVCCollectionVCPhotoAlbumImage.image = UIImage(systemName: "pencil")
        cell.StoresVCCollectionVCPhotoAlbumImage.image = StoresViewController.photos[indexPath.item]
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
    @IBOutlet weak var StoreVСProductImage: UIImageView!
    
    //buttons
    @IBOutlet weak var StoreVCPostingButtonOutlet: UIButton!
    @IBOutlet weak var StoresVCCustomArticleButtonOutlet: UIButton!
    @IBOutlet weak var StoresVCUploadPhotoButtonOutlet: UIButton!
    @IBOutlet weak var StoresVCUploadFirstPhotoOutlet: UIButton!
    
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
    
    
    //upload first photo
    @IBAction func StoresVCUploadFirstPhotoAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
        StoresVCUploadFirstPhotoOutlet.tag = 1
    }
    
    //upload seconds photo
    @IBAction func StoresVCUploadPhotoButtonAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
        StoresVCUploadPhotoButtonOutlet.tag = 1
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
    
    var album: [UIImage] = []
    var arraStrings: [String: String] = [:]
    var photosCount: Int = 0
    
    var urlArray: [URL] = []
    @IBAction func StoreVCPostingButtonAction(_ sender: Any) {
        
        // проверяем на заполненность полей
        showAlert()
        
            // 1. создаем новый продукт
            StoresViewController.product = self.creatNewProduct()
                    
            // создаем альбом фотографий для добавления к новому продукту
            self.album = self.generatePhotosAlbumArray()
            //        выгружаем сгенерированный массив фото в ФС БД и добавляем ссылки на фото в карточке товара
            FSStores.uploadPhoto(images: self.album) { array in
                self.arraStrings = array

            } completion1: { photosCount in
                self.photosCount = photosCount

            } urlArray: { urlArray in
                self.urlArray = urlArray
            }
        StoresViewController.product?.productPostArrayPhotos = self.urlArray
        
        StoresViewController.product?.productPostPhotoCount = StoresViewController.photos.count

        
        self.addProductToFS_DB()
        
  
        
        // переход на глобальное меню
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let globalMenu = storyboard.instantiateViewController(withIdentifier: "GlobalMenuStoreViewController") as! GlobalMenuStoreViewController
        
        self.navigationController?.pushViewController(globalMenu, animated: true)
        self.navigationController?.setViewControllers([globalMenu], animated: true)

        
    }
    
    // создаем новый продукт
    static var product: Product?

    
    func creatNewProduct() -> Product {
//        let array = FSStores.currentProductArrayStrings
        let urlURL = FSStores.urlURL
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
            productPostViewsCount: 0,
            productPostPhotoCount: 0,
            productPostIsNew: StoresVCisNewSC.titleForSegment(at: StoresVCisNewSC.selectedSegmentIndex)!,
            indexNumberOfProduct: (FBDataBase.count + 1), // присваиваем порядковый номер товару
            productPostArrayPhotos: urlURL // добавили массив ссылок на фотографии
        )
        return newProduct
    }
    
    func addProductToFS_DB() {
        
        StoresViewController.productArticle = StoresVCArticleField.text!
        
        
        let ref = Firestore.firestore().collection("stores").document((Auth.auth().currentUser?.email)!).collection("products")
        
        ref.document(String(FBDataBase.count + 1))
            .setData(StoresViewController.product!.productDict) {error in
                if error != nil {
                    print("error adding product to FB")
                }
            }

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
        
        StoreVСProductImage.image = nil
        
        
        
        //создание артикула
        StoresVCArticleField.text = Product.generateNewArticle()
        
        //установка текущей даты в DataPicker
        StoreVCPostingButtonOutlet.setTitle(generateDatePosting(), for: .normal)
        
        //установка фокуса на поле названия продукта
        StoresVCProductTitleField.becomeFirstResponder()
        
        self.StoresVCPhotosCollectionViewOutlet.dataSource = self
        self.StoresVCPhotosCollectionViewOutlet.delegate = self
        
        //таги для определения нажатой кнопки для уплоада фото
        StoresVCUploadPhotoButtonOutlet.tag = 0
        StoresVCUploadFirstPhotoOutlet.tag = 0
        
        // 1. общее число продуктов
        FSStores.getCurrentCountProducts { count in
            FBDataBase.count = count
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        FBDataBase.count = 0
    }
    

    
    //скрытие клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //custom functions
    
    //save photo in project
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //коллеция фото
        if StoresVCUploadPhotoButtonOutlet.tag == 0 && StoresVCUploadFirstPhotoOutlet.tag == 0 {
            
            let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue) ] as? UIImage
            //добавление в массив
            //            newProduct.productPostArrayPhotos?.append(image!)
            StoresViewController.photos.append(image!)
            
            //вставка в collection view
            StoresVCPhotosCollectionViewOutlet.insertItems(at: StoresVCPhotosCollectionViewOutlet.indexPathsForVisibleItems)
            
            
            StoresVCPhotosCollectionViewOutlet.clipsToBounds = true
            
            picker.dismiss(animated: true, completion: nil)
            
            StoresVCPhotosCollectionViewOutlet.reloadData()
            
            StoresVCUploadPhotoButtonOutlet.tag = 1
            
            
            //главное фото
        }
        
        if StoresVCUploadFirstPhotoOutlet.tag == 1 {
            
            let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue) ] as? UIImage
            //добавление в image view
            StoreVСProductImage.image = image
            
            StoresVCPhotosCollectionViewOutlet.insertItems(at: StoresVCPhotosCollectionViewOutlet.indexPathsForVisibleItems)
            StoresVCPhotosCollectionViewOutlet.clipsToBounds = true
            //добавление в базу данных
            StoresViewController.photos.append(image!)
            
            picker.dismiss(animated: true, completion: nil)
            StoresVCPhotosCollectionViewOutlet.reloadData()
            StoresVCUploadFirstPhotoOutlet.tag = 0
            
        }
        
        if StoresVCUploadPhotoButtonOutlet.tag == 1 {
            
            let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue) ] as? UIImage
            //добавление в массив
            //            newProduct.productPostArrayPhotos?.append(image!)
            StoresViewController.photos.append(image!)
            
            //вставка в collection view
            StoresVCPhotosCollectionViewOutlet.insertItems(at: StoresVCPhotosCollectionViewOutlet.indexPathsForVisibleItems)
            
            
            StoresVCPhotosCollectionViewOutlet.clipsToBounds = true
            
            picker.dismiss(animated: true, completion: nil)
            
            StoresVCPhotosCollectionViewOutlet.reloadData()
            
            StoresVCUploadPhotoButtonOutlet.tag = 1
            
        }
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
        let count = StoresViewController.photos.count
        for i in 0..<count {
            array.append(StoresViewController.photos[i])
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
        
        if StoresViewController.photos == [] {
            alerts.append(alertEnumStores.noProductPostArrayPhotos.rawValue + "\n")
        }
        
        if self.StoreVСProductImage.image == nil {
            alerts.append(alertEnumStores.noroductPostFirstImage.rawValue + "\n")
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

